Add-Type -AssemblyName System.Speech
$synth = New-Object System.Speech.Synthesis.SpeechSynthesizer
foreach ($voice in $synth.GetInstalledVoices()) {
    if ($voice.VoiceInfo.Gender -eq 'Female') {
        $synth.SelectVoice($voice.VoiceInfo.Name)
        break
    }
}
$synth.Speak("Ji Huzefa, maine ab se female voice mein bolna shuru kar diya hai!")
