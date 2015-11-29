## Step 1:
```
git clone git@bitbucket.org:arturictus/elixir_sips.git
cd mechanize
```
## Step 2:
create your _settings.yml_ file with this keys:
```YAML
download_folder: 'path/to/your/folder'
username: 'usename@name.com'
password: 'my_password'
```

## Step 3:
Run the script
```
irb
```
```ruby
require './elixir_sips'
SipsDown.new.download
```
