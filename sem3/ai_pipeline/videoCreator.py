from moviepy.editor import *
from moviepy.config import change_settings

# !!! KEEP THIS PATH FROM THE PREVIOUS STEP !!!
# change_settings({"IMAGEMAGICK_BINARY": r"C:\Program Files\ImageMagick-7.1.1-Q16-HDRI\magick.exe"})

def create_scrolling_lyrics(txt_file, audio_file, output_file="lyric_video.mp4", font_size=50, color='white', bg_color='black', start_delay=10):
    
    # 1. Read Text
    try:
        with open(txt_file, 'r', encoding='utf-8') as f:
            content = f.read()
    except FileNotFoundError:
        print(f"Error: Could not find {txt_file}")
        return

    # 2. Load Audio
    try:
        audio = AudioFileClip(audio_file)
        duration = audio.duration
    except OSError:
        print(f"Error: Could not find {audio_file}")
        return

    # 3. Create Text Clip
    video_width = 1280
    video_height = 720
    
    print("Generating text clip...")
    # Using 'Arial' as a safe default for Windows. 
    # Use 'method="caption"' to wrap text automatically into the width.
    txt_clip = TextClip(content, fontsize=font_size, color=color, 
                        size=(video_width - 100, None), 
                        method='caption', align='center', font='Arial')

    # 4. Define the Scrolling Logic with Delay
    def scroll_func(t):
        # Phase 1: The Delay (Intro)
        if t < start_delay:
            # Keep text just off the bottom of the screen
            return ('center', video_height)
        
        # Phase 2: The Scroll
        else:
            # We calculate how much time is actually available for scrolling
            scroll_duration = duration - start_delay
            
            # How much time has passed since the scrolling started?
            time_scrolled = t - start_delay
            
            # Ratio goes from 0 to 1 over the remaining time
            ratio = time_scrolled / scroll_duration
            
            # Start just below screen, end just above screen
            start_y = video_height
            end_y = -txt_clip.h 
            
            current_y = start_y + (end_y - start_y) * ratio
            return ('center', current_y)

    # 5. Apply logic
    final_clip = txt_clip.set_pos(scroll_func).set_duration(duration)

    # 6. Composite
    bg_clip = ColorClip(size=(video_width, video_height), color=ColorClip.color_dict[bg_color]).set_duration(duration)
    video = CompositeVideoClip([bg_clip, final_clip])

    # 7. Add Audio
    video = video.set_audio(audio)

    # 8. Render
    print(f"Rendering video (Duration: {duration}s with {start_delay}s delay)...")
    video.write_videofile(output_file, fps=24, codec='libx264', audio_codec='aac')
    print("Done! Video saved as", output_file)

if __name__ == "__main__":
    create_scrolling_lyrics(
        txt_file="p1.txt", 
        audio_file="p1.mp3",
        output_file="my_song_video.mp4",
        start_delay=10  # <--- Change this number to adjust delay in seconds
    )