class Contact {
  const Contact({
    required this.avatar,
    required this.name,
    required this.nameIndex,
  });

  final String avatar;
  final String name;
  final String nameIndex;
}

class ContactsPageData {
  final List<Contact> contacts = [
    const Contact(
      avatar: 'https://randomuser.me/api/portraits/men/53.jpg',
      name: 'Maurice Sutton',
      nameIndex: 'M',
    ),
    const Contact(
      avatar: 'https://randomuser.me/api/portraits/women/76.jpg',
      name: 'Jerry',
      nameIndex: 'J',
    ),
    const Contact(
      avatar: 'https://randomuser.me/api/portraits/women/17.jpg',
      name: 'Dangdang',
      nameIndex: 'D',
    ),
    const Contact(
      avatar: 'https://randomuser.me/api/portraits/women/55.jpg',
      name: 'Teddy',
      nameIndex: 'T',
    ),
    const Contact(
      avatar: 'https://randomuser.me/api/portraits/women/11.jpg',
      name: 'Steave',
      nameIndex: 'S',
    ),
    const Contact(
      avatar: 'https://randomuser.me/api/portraits/women/65.jpg',
      name: 'Vivian',
      nameIndex: 'V',
    ),
    const Contact(
      avatar: 'https://randomuser.me/api/portraits/women/50.jpg',
      name: 'Mary',
      nameIndex: 'M',
    ),
    const Contact(
      avatar: 'https://randomuser.me/api/portraits/women/91.jpg',
      name: 'David',
      nameIndex: 'D',
    ),
    const Contact(
      avatar: 'https://randomuser.me/api/portraits/women/60.jpg',
      name: 'Bob',
      nameIndex: 'B',
    ),
    const Contact(
      avatar: 'https://randomuser.me/api/portraits/men/60.jpg',
      name: 'Jeff Green',
      nameIndex: 'J',
    ),
    const Contact(
      avatar: 'https://randomuser.me/api/portraits/men/45.jpg',
      name: 'Adam',
      nameIndex: 'A',
    ),
    const Contact(
      avatar: 'https://randomuser.me/api/portraits/men/7.jpg',
      name: 'Michel',
      nameIndex: 'M',
    ),
    const Contact(
      avatar: 'https://randomuser.me/api/portraits/men/35.jpg',
      name: 'Green',
      nameIndex: 'G',
    ),
    const Contact(
      avatar: 'https://randomuser.me/api/portraits/men/64.jpg',
      name: 'Jack Ma',
      nameIndex: 'J',
    ),
    const Contact(
      avatar: 'https://randomuser.me/api/portraits/men/86.jpg',
      name: 'Tom',
      nameIndex: 'T',
    ),
    const Contact(
      avatar: 'https://randomuser.me/api/portraits/men/31.jpg',
      name: 'Zat',
      nameIndex: 'Z',
    ),
    const Contact(
      avatar: 'https://randomuser.me/api/portraits/women/13.jpg',
      name: 'Zlia',
      nameIndex: 'Z',
    ),
  ];

  static ContactsPageData mock() {
    return ContactsPageData();
  }
}
