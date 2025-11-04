@extends('layouts.app')

@section('title','Home — Moussa Jaafar')

@section('content')
<section class="hero">
  <h1 class="hero-title">Hi, I’m <span class="accent">Moussa Jaafar</span></h1>
  <p class="hero-sub">Full Stack Web Developer — Laravel, PHP, JavaScript, MySQL. I build modern and responsive web apps with focus on clean code and UX.</p>

  <div class="hero-actions">
    <a href="/projects" class="btn-primary">View Projects</a>
    <a href="/about" class="btn-ghost">About Me</a>
  </div>

  <div class="quick-stats">
    <div><strong>Location</strong><span>Beirut, Lebanon</span></div>
    <div><strong>Email</strong><span>moussajaafar8@gmail.com</span></div>
    <div><strong>GitHub</strong><a href="https://github.com/Moussa404" target="_blank">github.com/Moussa404</a></div>
  </div>
</section>
@endsection
