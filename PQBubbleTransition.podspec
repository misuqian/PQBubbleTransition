Pod::Spec.new do |s|
  s.name = 'PQBubbleTransition'
  s.version = '0.1'
  s.license = 'MIT'
  s.summary = 'A custom modal transition that presents and dismiss a controller with an expanding bubble effect.'
  s.description  = <<-DESC
                    Different version from [andreamazz/BubbleTransition].Easy to use custom modal animation that 					presents the new controller
                    within a bubble, expanding to cover the whole screen.
                   DESC
  s.homepage = 'https://github.com/misuqian/PQBubbleTransition'
  s.authors = { 'misuqian' => '594949581@qq.com' }
  s.source = { :git => 'https://github.com/misuqian/PQBubbleTransition.git', :tag => s.version }

  s.ios.deployment_target = '8.0'

  s.source_files = 'Source/*.{h,m}'

  s.requires_arc = true
end