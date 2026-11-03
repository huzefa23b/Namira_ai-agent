$desktop = [Environment]::GetFolderPath('Desktop')
Write-Host "Desktop path: $desktop"
$wavPath = Join-Path $desktop "namira_hindi_voice.wav"

Add-Type -AssemblyName System.Speech
$synth = New-Object System.Speech.Synthesis.SpeechSynthesizer
$synth.SetOutputToWaveFile($wavPath)
$synth.Speak("Namaste Huzefa! Main Namira hoon, aapki personal assistant.")
$synth.Dispose()

Write-Host "Saved to $wavPath"
