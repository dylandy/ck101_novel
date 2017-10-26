require "./build_cache"
require "rake"

desc "build all cache lists"
task :build_all_cache do
  NovelGrab.build_cache_for_long_novel
  NovelGrab.build_cache_for_short_novel
  NovelGrab.build_cache_for_finished_novel
  NovelGrab.build_cache_for_japanese_novel
  NovelGrab.build_cache_for_danmei_novel
  NovelGrab.build_cache_for_yenchin_novel
  NovelGrab.build_cache_for_published_yenchin_novel
end

desc "build long cache lists"
task :build_long_cache do
  NovelGrab.build_cache_for_long_novel
end

desc "build short cache lists"
task :build_short_cache do
  NovelGrab.build_cache_for_short_novel
end

desc "build finished cache lists"
task :build_finished_cache do
  NovelGrab.build_cache_for_finished_novel
end

desc "build japanese cache lists"
task :build_japanese_cache do
  NovelGrab.build_cache_for_japanese_novel
end

desc "build danmei cache lists"
task :build_danmei_cache do
  NovelGrab.build_cache_for_danmei_novel
end

desc "build yenchin cache lists"
task :build_yenchin_cache do
  NovelGrab.build_cache_for_yenchin_novel
end

desc "build published yenchin cache lists"
task :build_published_yenchin_cache do
  NovelGrab.build_cache_for_published_yenchin_novel
end
