@extends('layouts.app')

@section('title', 'Contact — Moussa Jaafar')

@section('content')
<section class="contact-page">
  <h2>Contact</h2>

  <div class="contact-grid">
    <div class="card">
      <h4>Email</h4>
      <p><a href="mailto:moussajaafar8@gmail.com">moussajaafar8@gmail.com</a></p>
    </div>

    <div class="card">
      <h4>LinkedIn</h4>
      <p><a href="https://www.linkedin.com/in/moussa-j-784081254" target="_blank">Moussa Jaafar</a></p>
    </div>
  </div>
</section>

<section class="contact-section">
  <h3 class="section-title">💬 Get in Touch</h3>
  <p class="section-subtitle">Let’s collaborate or just say hi — I’ll respond as soon as possible.</p>

  <form method="POST" action="{{ route('send.message') }}" class="contact-form">
    @csrf

    <div class="form-group">
      <label for="name">Your Name</label>
      <input type="text" id="name" name="name" placeholder="Enter your name" required>
    </div>

    <div class="form-group">
      <label for="email">Your Email</label>
      <input type="email" id="email" name="email" placeholder="Enter your email" required>
    </div>

    <div class="form-group">
      <label for="message">Message</label>
      <textarea id="message" name="message" rows="6" placeholder="Type your message..." required></textarea>
    </div>

    <button type="submit" class="btn-primary">
      <span>Send Message 🚀</span>
    </button>

    @if (session('success'))
      <div class="alert-success">
        {{ session('success') }}
      </div>
    @endif
  </form>
</section>
@endsection
