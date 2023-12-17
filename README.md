<p align="center">
  <h1 align="center">🎙️ AudioGrapher v1.0 🌐</h1>
</p>

<p align="center">
Welcome to AudioGrapher, a creative project that records or imports audio, transcribes it into text, and generates a word cloud from the transcribed text. 🎉
</p>

<p align="center">
  <h2 align="center">📦 Dependencies</h2>
</p>

<p align="center">
This project requires the following R packages:

- audio 🎵
- rjson 📄
- httr 🌐
- tm 📚
- SnowballC ❄️
- wordcloud ☁️
- RColorBrewer 🎨

These packages can be installed using the `install.packages()` function in R.
</p>

<p align="center">
  <h2 align="center">🚀 Usage</h2>
</p>

<p align="center">
Run the `main()` function in the `main.r` script. You will be presented with four options:

1. Record audio 🎤
2. Import txt file 📄
3. Import wav file 🎵
4. Exit 🚪
</p>

<p align="center">
  <h2 align="center">📂 Files</h2>
</p>

<p align="center">
The following temporary files are generated during the execution of the program:

- `temp.wav`: This file contains the recorded audio. 🎵
- `temp.txt`: This file contains the transcribed text from the audio. 📄

These files are overwritten each time you run the program. 🔄
</p>

<p align="center">
  <h2 align="center">🔑 Note</h2>
</p>

<p align="center">
The transcription service used in this project is provided by Microsoft's Speech to Text service. You will need to replace the `Ocp-Apim-Subscription-Key` in the `transcribe_audio()` function with your own subscription key. 🔐
</p>

<p align="center">
  <h2 align="center">📝 Version</h2>
</p>

<p align="center">
This is version 1.0 of AudioGrapher. 🎉
</p>

<p align="center">
  <h2 align="center">🙋‍♂️ Author</h2>
</p>

<p align="center">
This project was created by <a href="https://github.com/ripgamer">@ripgamer</a>. 👏
</p>