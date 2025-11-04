<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Mail;

class MailController extends Controller
{
    public function send(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:100',
            'email' => 'required|email',
            'message' => 'required|string|max:1000',
        ]);

        // Optional: log to check if called
        logger('MailController@send triggered');

        // Discord test message
        Http::post(env('DISCORD_WEBHOOK_URL'), [
            'content' => "🚀 New portfolio message from {$request->name} ({$request->email}): {$request->message}"
        ]);

        return back()->with('success', 'Message sent successfully!');
    }
}
