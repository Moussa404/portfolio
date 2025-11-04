@extends('layouts.app')

@section('title','Projects — Moussa Jaafar')

@section('content')
<section class="projects-page">
  <h2>Featured Projects</h2>

  <div class="projects grid">
    <!-- Static projects from CV -->
    <article class="project-card">
      <h3>Laravel Blog</h3>
      <p>A full-featured blog built with Laravel (auth, CRUD posts, comments). <a href="https://github.com/Moussa404/laravel-blog" target="_blank">View code</a></p>
      <div class="meta"><span>Laravel</span><span>MySQL</span></div>
    </article>

    
    <article class="project-card">
      <h3>E-Commerce Website (CV)</h3>
      <p>Online shop with product listing, cart, checkout. Built with Laravel & MySQL. (Jan 2024 – Apr 2024)</p>
      <div class="meta"><span>Laravel</span><span>API</span></div>
    </article>
  </div>

  <h2 style="margin-top:40px">Other Public Repositories (from GitHub)</h2>
  <div id="github-repos" class="projects grid">
    <!-- JS will inject GitHub repos here -->
    <div class="loading">Loading repos from GitHub…</div>
  </div>
</section>
@endsection
