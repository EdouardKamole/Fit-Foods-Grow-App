import 'package:flutter/material.dart';

class CertificatesScreen extends StatelessWidget {
  const CertificatesScreen({super.key});

  final List<Map<String, dynamic>> _certificates = const [
    {
      'title': 'Basic Gardening Certificate',
      'date': '2024-01-15',
      'score': '95%',
    },
    {
      'title': 'Plant Nutrition Expert',
      'date': '2024-02-01',
      'score': '88%',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Certificates'),
      ),
      body: _certificates.isEmpty
          ? _buildEmptyState()
          : _buildCertificatesList(context),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.card_membership, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 16),
          const Text(
            'No certificates yet',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Complete courses to earn certificates!',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildCertificatesList(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _certificates.length,
      itemBuilder: (context, index) {
        final certificate = _certificates[index];
        return Card(
          child: ListTile(
            leading: const Icon(Icons.card_membership,
                size: 40, color: Colors.green),
            title: Text(certificate['title']),
            subtitle: Text('Earned on ${certificate['date']}'),
            trailing: Chip(
              label: Text(certificate['score']),
              backgroundColor: Colors.green[100],
            ),
            onTap: () => _showCertificateDetails(context, certificate),
          ),
        );
      },
    );
  }

  void _showCertificateDetails(
      BuildContext context, Map<String, dynamic> certificate) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(certificate['title']),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.card_membership, size: 60, color: Colors.green),
            const SizedBox(height: 16),
            Text('Score: ${certificate['score']}'),
            Text('Date: ${certificate['date']}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              // Share certificate functionality
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Share feature coming soon!')),
              );
            },
            child: const Text('Share'),
          ),
        ],
      ),
    );
  }
}
