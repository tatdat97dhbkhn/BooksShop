authors = [
  {
    name: "Phạm Tất Đạt"
  },
  {
    name: "Trần Trọng Quang"
  },
  {
    name: "Trịnh Minh Dũng"
  }
]
Author.create authors

categories = [
  {
    name: "Songbooks"
  },
  {
    name: "Education & Reference"
  },
  {
    name: "Art History"
  }
]
Category.create categories

books = [
  {
    name: "The Beatles Anthology",
    price: rand(3..15),
    description: "The Beatles Anthology tells, for the first time, the story of the Beatles by the Beatles. This extraordinary project has been made possible because Paul McCartney, George Harrison and Ringo Starr agreed to tell their combined story especially for this book. Together with Yoko Ono Lennon, they also made available the full transcripts (including all the outtakes) of the television and video series The Beatles Anthology",
    public_date: rand(10.years).seconds.ago ,
    image: "img1.jpg",
    author_id: 1,
    category_id: 1
  },
  {
    name: "Mary, Did You Know?",
    price: rand(3..15),
    description: "Mary, Did You Know? the classic song continues to be a seasonal favorite on airplay. Author and music artist Mark Lowry offers an expanded view of his highly successful Christmas song, Mary, Did You Know? in this classic gift book. This perennial seller will have a wonderful new and updated design, as well as refreshed text including a new foreword with inspirational insights by Gloria Gaither. CD includes song sung by Lowry and the Gaither Vocal",
    public_date: rand(10.years).seconds.ago ,
    image: "img2.jpg",
    author_id: 1,
    category_id: 1
  },
  {
    name: "Alcoholics Anonymous",
    price: rand(3..15),
    description: "Alcoholics Anonymous sets forth cornerstone concepts of recovery from alcoholism and tells the stories of men and women who have overcome the disease. The fourth edition includes twenty-four new stories that provide contemporary sharing for newcomers seeking recovery from alcoholism in A.A. during the early years of the 21st century. Sixteen stories are retained from the third edition, including the Pioneers of A.A section, which helps the reader.",
    public_date: rand(10.years).seconds.ago ,
    image: "img3.jpg",
    author_id: 1,
    category_id: 2
  },
  {
    name: "The Great Gatsby",
    price: rand(3..15),
    description: "No Synopsis Available.",
    public_date: rand(10.years).seconds.ago ,
    image: "his_04.jpg",
    author_id: 1,
    category_id: 2
  },
  {
    name: "The Kite Runner",
    price: rand(3..15),
    description: "No Synopsis Available.",
    public_date: rand(10.years).seconds.ago ,
    image: "his_05.jpg",
    author_id: 1,
    category_id: 2
  },
  {
    name: "Into the Wild",
    price: rand(3..15),
    description: "In April 1992 a young man from a well-to-do family hitchhiked to Alaska and walked alone into the wilderness north of Mt. McKinley. His name was Christopher Johnson McCandless. He had given $25,000 in savings to charity, abandoned his car and most of his possessions, burned all the cash in his wallet, and invented a new life for himself.",
    public_date: rand(10.years).seconds.ago ,
    image: "his_06.jpg",
    author_id: 1,
    category_id: 3
  },
  {
    name: "Fast Food Nation: The Dark Side of the All-American Meal",
    price: rand(3..15),
    description: "Fastfood Nation is a detailed research into the fastfood industry. It appears to be marketed as an expose detailing how fastfood makes you fat and ruins the world. Happily it isn't that. Instead it is a thorough fact based description of all aspects of the fastfood industry.",
    public_date: rand(10.years).seconds.ago ,
    image: "his_07.jpg",
    author_id: 1,
    category_id: 3
  },
  {
    name: "Number the Stars",
    price: rand(3..15),
    description: "As the German troops begin their campaign to relocate all the Jews of Denmark, Annemarie Johansen’s family takes in Annemarie’s best friend, Ellen Rosen, and conceals her as part of the family.Through the eyes of ten-year-old Annemarie, we watch as the Danish Resistance smuggles almost the entire Jewish population of Denmark, nearly seven thousand people, across the sea to Sweden. ",
    public_date: rand(10.years).seconds.ago ,
    image: "his_08.jpg",
    author_id: 1,
    category_id: 3
  },
  {
    name: "Learn to Read Music",
    price: rand(3..15),
    description: "This book Will -teach the notation of music to those who have never known it before -serve as a systematic reminder for those who once knew how to read music but have forgotten most of it -serve as a practical classroom text book in the rudiments of music -serve as a helpful reference book for the student in music appreciation and related courses This book Will Not -teach you to sing like Tebaldi -make you a wizard at the piano or any other instrument",
    public_date: rand(10.years).seconds.ago ,
    image: "edu_01.jpg",
    author_id: 2,
    category_id: 1
  },
  {
    name: "101 Hymn Stories : The Inspiring True Stories Behind 101 Favorite Hymns",
    price: rand(3..15),
    description: "Perfect for devotions, sermon illustrations, bulletin inserts, and introducing congregational hymns, this collection of uplifting, informative hymn stories includes each hymn's full text and musical score as well as information about the author, composer, and Scripture that inspired the song. Some of the well-loved hymns included are: A Mighty Fortress Fairest Lord Jesus How Great Thou Art Jesus Loves Me Silent Night Amazing Grace Holy, Holy, Holy",
    public_date: rand(10.years).seconds.ago ,
    image: "edu_02.jpg",
    author_id: 2,
    category_id: 1
  },
  {
    name: "How to Read Music : Fundamentals of Music Notation Made Easy",
    price: rand(3..15),
    description: "A basic primer for anyone without musical training who wishes to learn to read musical scores when singing or taking up an instrument. The book explains how notes are named and written; how to read melody, interpret time signatures, keys, sharps, flats, and naturals; how to read tempo; and how to play chords.",
    public_date: rand(10.years).seconds.ago ,
    image: "edu_03.jpg",
    author_id: 2,
    category_id: 1
  },
  {
    name: "The Outsiders",
    price: rand(3..15),
    description: "50 years of an iconic classic This international bestseller and inspiration for a beloved movie is a heroic story of friendship and belonging. No one ever said life was easy. But Ponyboy is pretty sure that he's got things figured out. He knows that he can count on his brothers, Darry and Sodapop. And he knows that he can count on his friends--true friends who would do anything for him, like Johnny and Two-Bit. But not on much else besides trouble...",
    public_date: rand(10.years).seconds.ago ,
    image: "edu_04.jpg",
    author_id: 2,
    category_id: 2
  },
  {
    name: "Como Fazer Amigos e Influenciar Pessoas - Audiolivro",
    price: rand(3..15),
    description: "No Synopsis Available.",
    public_date: rand(10.years).seconds.ago ,
    image: "edu_05.jpg",
    author_id: 2,
    category_id: 2
  },
  {
    name: "Their Eyes Were Watching God",
    price: rand(3..15),
    description: "Belongs in the category ... of enduring American literature.-- Saturday Review Fair and long-legged, independent and articulate, Janie Crawford sets out to be her own person -- no mean feat for a black woman in the '30s. Janie's quest for identity takes her through three marriages and into a journey back to her roots.",
    public_date: rand(10.years).seconds.ago ,
    image: "edu_06.jpg",
    author_id: 2,
    category_id: 2
  },
  {
    name: "Holes",
    price: rand(3..15),
    description: "Stanley Yelnats is under a curse. A curse that began with his no-good-dirty-rotten-pig-stealing-great-great-grandfather and has since followed generations of Yelnats.",
    public_date: rand(10.years).seconds.ago ,
    image: "edu_07.jpg",
    author_id: 2,
    category_id: 3 
  },
  {
    name: "Diario",
    price: rand(3..15),
    description: "Spanish translation of this classic diary: In Amsterdam, in the summer of 1942, the Nazis forced teenager Anne Frank and her family into hiding. ",
    public_date: rand(10.years).seconds.ago ,
    image: "edu_08.jpg",
    author_id: 2,
    category_id: 3
  },
  {
    name: "Solo Guitar Playing",
    price: rand(3..15),
    description: "This second volume of the popular classical guitar method features instruction, graded exercises, practice studies, and a survey of the guitar repertoire. Volume Two develops technique, sightreading, and includes an advanced repertoire of thirty works.",
    public_date: rand(10.years).seconds.ago ,
    image: "song_01.jpg",
    author_id: 3,
    category_id: 1
  },
  {
    name: "How to Play the Hawaiian Ukulele : 10 Easy Lessons",
    price: rand(3..15),
    description: "How to Play the Hawaiian Ukulele is an easy-to-follow guide for anyone interested in this popular Hawaiian musical instrument. In ten easy lessons, readers will learn how to read music, strumming techniques, finger exercises, accompaniments and songs that they can sing along to. A glossary and chord chart are included for easy reference.",
    public_date: rand(10.years).seconds.ago ,
    image: "song_02.jpg",
    author_id: 3,
    category_id: 1
  },
  {
    name: "Face Down",
    price: rand(3..15),
    description: "Most believers understand that worship is not a compartmentalized aspect of the Christian experience but rather it is the motivation-the driving force-behind all that we do and are. We exist to worship God. For years we have been basking in God's love and worshiping Him with uplifted hands and hearts. Now we need to go deeper and see that God is also an awesome, mysterious being that should engender our silent, even dumbstruck-reverence for His holiness",
    public_date: rand(10.years).seconds.ago ,
    image: "song_03.jpg",
    author_id: 3,
    category_id: 1
  },
  {
    name: "Quem Mexeu no Meu Queijo?: para Crianças",
    price: rand(3..15),
    description: "Spencer Johnson ajudou pessoas em todo o mundo a se adaptarem e superarem mudanças e a vencerem os mais diversos obstáculos. seconds.agora, o autor apresenta uma nova, divertida, mas não menos eficaz versão de seu grande sucesso, que vendeu mais de 1 milhão de exemplares só no Brasil. Ilustrado, Quem Mexeu No Meu Queijo? Para Crianças mostra para os pequenos que as mudanças podem ser positivas, nos levando para novas oportunidades e descobertas.",
    public_date: rand(10.years).seconds.ago ,
    image: "song04.jpg",
    author_id: 3,
    category_id: 2
  },
  {
    name: "The Alchemist",
    price: rand(3..15),
    description: "The Alchemist by Paulo Coelho continues to change the lives of its readers forever. With more than two million copies sold around the world, The Alchemist has established itself as a modern classic, universally admired.Paulo Coelho's masterpiece tells the magical story of Santiseconds.ago, an Andalusian shepherd boy who yearns to travel in search of a worldly treasure as extravagant as any ever found.The story of the treasures Santiseconds.ago finds along the way..",
    public_date: rand(10.years).seconds.ago ,
    image: "song_05.jpg",
    author_id: 3,
    category_id: 2
  },
  {
    name: "Midnight in the Garden of Good and Evil: A Savannah Story",
    price: rand(3..15),
    description: "Shots rang out in Savannah's grandest mansion in the misty,early morning hours of May 2, 1981. Was it murder or self-defense? For nearly a decade, the shooting and its aftermath reverberated throughout this hauntingly beautiful city of moss-hung oaks and shaded squares.",
    public_date: rand(10.years).seconds.ago ,
    image: "song_06.jpg",
    author_id: 3,
    category_id: 2
  },
  {
    name: "Man's Search for Meaning",
    price: rand(3..15),
    description: " Based on his own experience and the experiences of others he treated later in his practice, Frankl argues that we cannot avoid suffering but we can choose",
    public_date: rand(10.years).seconds.ago ,
    image: "song_07.jpg",
    author_id: 3,
    category_id: 3
  },
  {
    name: "Frankenstein",
    price: rand(3..15),
    description: "Few creatures of horror have seized readers' imaginations and held them for so long as the anguished monster of Mary Shelley's Frankenstein . ",
    public_date: rand(10.years).seconds.ago ,
    image: "song_08.jpg",
    author_id: 3,
    category_id: 3
  }
]
Book.create books
