# Elixir Sips Downloader
Download all the episodes from [Elixir Sips](http://elixirsips.com/).
You need to have a paid Subscription.

## Step 1:
```
git clone git@github.com:arturictus/elixir_sips_downloader.git
cd elixir_sips_downloader
```
## Step 2:
Install dependencies:
```
bundle install
```
## Step 3:
Fill your settings in _settings.yml_ file
```
cp settings.example.yml settings.yml
```
_Yaml example:_
```YAML
download_folder: 'path/to/your/folder'
username: 'usename@name.com'
password: 'my_password'
```

## Step 4:
Run the script
```
ruby bin/download
```

## Notes:

The script will start downloading all the episodes in ascending order. If you already downloaded episodes it will skip this files.

Output example:

```
$ ruby bin/download
Login in...
Inside ShowPage 001 - Introduction and Installing Elixir | Elixir Sips
Skiping file: 001_Introduction_and_Installing_Elixir.mkv
File Already exists /Users/arturpanach/Desktop/elixirsips/001 - Introduction and Installing Elixir/001_Introduction_and_Installing_Elixir.mp4
File Already exists /Users/arturpanach/Desktop/elixirsips/001 - Introduction and Installing Elixir/001_Introduction_and_Installing_Elixir.md
```
