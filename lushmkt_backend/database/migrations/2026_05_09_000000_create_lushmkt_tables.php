<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        // 1. Categories
        Schema::create('categories', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->string('slug')->unique();
            $table->string('icon')->nullable();
            $table->enum('type', ['service', 'product']);
            $table->boolean('is_active')->default(true);
            $table->timestamps();
        });

        // 2. Services (e.g. Facebook Like, Follow)
        Schema::create('services', function (Blueprint $table) {
            $table->id();
            $table->foreignId('category_id')->constrained('categories')->onDelete('cascade');
            $table->string('name');
            $table->string('code')->unique();
            $table->decimal('price_per_one', 12, 2);
            $table->integer('min_quantity')->default(100);
            $table->integer('max_quantity')->default(100000);
            $table->text('description')->nullable();
            $table->boolean('is_active')->default(true);
            $table->timestamps();
        });

        // 3. Products (e.g. VIA, Gmail accounts)
        Schema::create('products', function (Blueprint $table) {
            $table->id();
            $table->foreignId('category_id')->constrained('categories')->onDelete('cascade');
            $table->string('name');
            $table->decimal('price', 12, 2);
            $table->integer('stock_quantity')->default(0);
            $table->text('description')->nullable();
            $table->text('warranty_policy')->nullable();
            $table->float('rating')->default(5.0);
            $table->timestamps();
        });

        // 4. Orders
        Schema::create('orders', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained('users')->onDelete('cascade');
            $table->enum('order_type', ['service', 'product']);
            $table->unsignedBigInteger('orderable_id'); // ID of service or product
            $table->integer('quantity');
            $table->decimal('total_price', 12, 2);
            $table->enum('status', ['pending', 'processing', 'completed', 'failed'])->default('pending');
            $table->text('target_link')->nullable(); // For FB like, follow targets
            $table->text('response_data')->nullable(); // Account files delivered
            $table->timestamps();
        });

        // 5. Transactions (deposits & payments)
        Schema::create('transactions', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained('users')->onDelete('cascade');
            $table->string('transaction_code')->unique();
            $table->enum('type', ['deposit', 'payment', 'refund']);
            $table->decimal('amount', 12, 2);
            $table->string('payment_method')->default('bank');
            $table->enum('status', ['pending', 'success', 'failed'])->default('pending');
            $table->text('description')->nullable();
            $table->timestamps();
        });

        // 6. Support Tickets
        Schema::create('tickets', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained('users')->onDelete('cascade');
            $table->string('title');
            $table->string('department')->default('technical');
            $table->enum('priority', ['low', 'medium', 'high'])->default('medium');
            $table->enum('status', ['open', 'replied', 'closed'])->default('open');
            $table->timestamps();
        });

        // 7. Ticket Messages
        Schema::create('ticket_messages', function (Blueprint $table) {
            $table->id();
            $table->foreignId('ticket_id')->constrained('tickets')->onDelete('cascade');
            $table->foreignId('user_id')->constrained('users')->onDelete('cascade');
            $table->text('message');
            $table->timestamps();
        });

        // 8. Notifications
        Schema::create('notifications', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained('users')->onDelete('cascade');
            $table->string('title');
            $table->text('content');
            $table->boolean('is_read')->default(false);
            $table->string('type')->default('system');
            $table->timestamps();
        });

        // 9. Banners
        Schema::create('banners', function (Blueprint $table) {
            $table->id();
            $table->string('title')->nullable();
            $table->string('image_path');
            $table->string('link_url')->nullable();
            $table->boolean('is_active')->default(true);
            $table->timestamps();
        });

        // 10. Coupons
        Schema::create('coupons', function (Blueprint $table) {
            $table->id();
            $table->string('code')->unique();
            $table->decimal('discount_amount', 12, 2);
            $table->enum('discount_type', ['percentage', 'fixed'])->default('fixed');
            $table->decimal('min_order_value', 12, 2)->default(0);
            $table->timestamp('expires_at')->nullable();
            $table->timestamps();
        });

        // 11. Reviews
        Schema::create('reviews', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained('users')->onDelete('cascade');
            $table->foreignId('product_id')->constrained('products')->onDelete('cascade');
            $table->tinyInteger('rating')->default(5);
            $table->text('comment')->nullable();
            $table->timestamps();
        });

        // 12. Settings
        Schema::create('settings', function (Blueprint $table) {
            $table->id();
            $table->string('key')->unique();
            $table->text('value')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('settings');
        Schema::dropIfExists('reviews');
        Schema::dropIfExists('coupons');
        Schema::dropIfExists('banners');
        Schema::dropIfExists('notifications');
        Schema::dropIfExists('ticket_messages');
        Schema::dropIfExists('tickets');
        Schema::dropIfExists('transactions');
        Schema::dropIfExists('orders');
        Schema::dropIfExists('products');
        Schema::dropIfExists('services');
        Schema::dropIfExists('categories');
    }
};
