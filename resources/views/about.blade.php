@extends('layouts.app')

@section('title','About — Moussa Jaafar')

@section('content')
<section class="about-me">
  <h2>About Me</h2>
  <p class="lead">
    Full Stack Web Developer with hands-on experience building responsive web applications using Laravel and modern front-end tools. Strong background in debugging, UI/UX basics and working with MySQL.
  </p>

  <div class="grid-two">
    <div class="card">
      <h3>Education</h3>
      <p><strong>License Technique in IT</strong><br>AL-Afaq, Beirut — 2023–2024</p>
    </div>

    <div class="card">
      <h3>Certifications</h3>
      <ul>
        <li>Full Stack Web Development — Youbee.ai</li>
        <li>Fundamentals of Cyber Security — Youbee.ai</li>
      </ul>
    </div>
  </div>

  <h3 class="section-title">Experience (select)</h3>
  <div class="card project-detail">
    <h4>Social Media Website</h4>
    <p>Dec 2024 – Mar 2025 — Designed and developed a social platform with registration, login, and interactive features using Laravel & MySQL. Worked on front-end responsiveness and SEO basics.</p>
  </div>

  <div class="card project-detail">
    <h4>E-Commerce Website (Online Store)</h4>
    <p>Jan 2024 – Apr 2024 — Built product listings, cart and checkout logic using Laravel and integrated APIs for dynamic product management.</p>
  </div>

  <h3 class="section-title">Skills</h3>
  <div class="skills">
    <span>PHP</span><span>Laravel</span><span>JavaScript</span><span>HTML</span><span>CSS</span><span>MySQL</span><span>Git</span>
  </div>
</section>
@endsection
