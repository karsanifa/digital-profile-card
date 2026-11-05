import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // 1. Status Like
  int _likeCount = 0;
  bool _isLiked = false;

  // 2. Status Follow
  bool _isFollowing = false;

  // 3. Fitur Ganti Warna Background Realtime
  final List<Color> _bgColors = [
    const Color.fromARGB(255, 119, 174, 236), // Warna asal
    const Color.fromARGB(255, 144, 224, 239), // Soft Cyan
    const Color.fromARGB(255, 203, 178, 254), // Soft Purple
    const Color.fromARGB(255, 255, 200, 221), // Soft Pink
    const Color.fromARGB(255, 52, 58, 64),   // Dark Mode
  ];
  int _selectedColorIndex = 0;

  // 4. Fitur Opsi Foto Profil (Tersimpan di Kode)
  // Bisa diisi path assets lokal atau URL gambar online sebagai alternatif
  final List<String> _profileImages = [
    'assets/gojo.jpg', // Asset lokal kamu
    'assets/lupi.png', // Opsi URL 1
    'assets/ye.jpg', // Opsi URL 2
    'assets/ada.jpg', // Opsi URL 3
  ];
  int _currentImageIndex = 0;

  // Fungsi Ganti Like
  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
      _isLiked ? _likeCount++ : _likeCount--;
    });
  }

  // Fungsi Ganti Foto Profil
  void _changeProfilePicture() {
    setState(() {
      _currentImageIndex = (_currentImageIndex + 1) % _profileImages.length;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Foto profil diubah ke opsi ${_currentImageIndex + 1}'),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // Helper untuk menentukan jenis provider gambar (Asset / Network)
  ImageProvider _getImageProvider(String path) {
    if (path.startsWith('http')) {
      return NetworkImage(path);
    }
    return AssetImage(path);
  }

  // Dialog Komentar
  void _showCommentDialog() {
    final TextEditingController commentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('Leave a Comment'),
          content: TextField(
            controller: commentController,
            decoration: const InputDecoration(
              hintText: 'Type your comment here...',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Pop-up Notifikasi Terima Kasih
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Thanks for your comment!'),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: const Text('Send'),
            ),
          ],
        );
      },
    );
  }

  // Dialog Share
  void _shareProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile link copied to clipboard!'),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColors[_selectedColorIndex],
      appBar: AppBar(
        title: const Text('Digital Profile Card'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Pilihan Warna Background Realtime
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Theme Color: ',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                    const SizedBox(width: 8),
                    Row(
                      children: List.generate(_bgColors.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedColorIndex = index;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              color: _bgColors[index],
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: _selectedColorIndex == index
                                    ? Colors.black
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Kartu Profil Utama
              Container(
                width: 300,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 195, 231, 228),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 12,
                      offset: const Offset(5, 5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Foto Profil Interaktif (Bisa Ditekan untuk Berganti Foto)
                    GestureDetector(
                      onTap: _changeProfilePicture,
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 45,
                            backgroundImage: _getImageProvider(
                              _profileImages[_currentImageIndex],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.cameraswitch,
                              size: 16,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Tap photo to change',
                      style: TextStyle(fontSize: 10, color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 10),

                    // Nama Lengkap
                    const Text(
                      'Gojo Satoru',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Subtitle / Jurusan
                    const Text(
                      'Student of Informatics Engineering',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(255, 64, 167, 201),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Row Icon & Kampus
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.school, size: 14, color: Colors.grey[700]),
                        const SizedBox(width: 4),
                        Text(
                          'State Polytechnic of Jember',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Tombol Follow (Interaktif)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _isFollowing = !_isFollowing;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _isFollowing
                              ? Colors.grey[400]
                              : const Color.fromARGB(255, 64, 167, 201),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          _isFollowing ? 'Following' : '+ Follow',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Baris Tombol Interaktif (Like, Comment, Share)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Tombol Like
                        IconButton(
                          onPressed: _toggleLike,
                          icon: Icon(
                            _isLiked ? Icons.favorite : Icons.favorite_border,
                            color: _isLiked ? Colors.red : Colors.grey[700],
                          ),
                          tooltip: 'Like',
                        ),
                        Text(
                          '$_likeCount',
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(width: 10),

                        // Tombol Comment
                        IconButton(
                          onPressed: _showCommentDialog,
                          icon: Icon(Icons.comment, color: Colors.grey[700]),
                          tooltip: 'Comment',
                        ),

                        // Tombol Share
                        IconButton(
                          onPressed: _shareProfile,
                          icon: Icon(Icons.share, color: Colors.grey[700]),
                          tooltip: 'Share',
                        ),
                      ],
                    ),

                    const Divider(height: 24),

                    // Tautan Cepat Sosial Media
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildSocialIcon(Icons.code, 'GitHub'),
                        const SizedBox(width: 16),
                        _buildSocialIcon(Icons.work, 'LinkedIn'),
                        const SizedBox(width: 16),
                        _buildSocialIcon(Icons.email, 'Email'),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget Pembantu Sosial Media
  Widget _buildSocialIcon(IconData icon, String name) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Opening $name profile...'),
            duration: const Duration(seconds: 1),
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
      child: CircleAvatar(
        radius: 16,
        backgroundColor: Colors.white,
        child: Icon(icon, size: 16, color: Colors.grey[800]),
      ),
    );
  }
}