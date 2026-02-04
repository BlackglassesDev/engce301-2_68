-- ============================================
-- Library Management System Database Schema
-- ============================================

PRAGMA foreign_keys = ON;

-- ===== BOOKS TABLE =====
CREATE TABLE IF NOT EXISTS books (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    author TEXT NOT NULL,
    isbn TEXT UNIQUE,
    category TEXT,
    total_copies INTEGER NOT NULL DEFAULT 1 CHECK(total_copies >= 0),
    available_copies INTEGER NOT NULL DEFAULT 1 CHECK(available_copies >= 0),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- ===== MEMBERS TABLE =====
CREATE TABLE IF NOT EXISTS members (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    phone TEXT,
    membership_date DATE DEFAULT CURRENT_DATE,
    status TEXT NOT NULL CHECK(status IN ('active', 'inactive'))
);


-- ===== BORROWINGS TABLE =====
CREATE TABLE IF NOT EXISTS borrowings (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    book_id INTEGER NOT NULL,
    member_id INTEGER NOT NULL,
    borrow_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE,
    status TEXT NOT NULL CHECK(status IN ('borrowed', 'returned', 'overdue')),
    FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE,
    FOREIGN KEY (member_id) REFERENCES members(id) ON DELETE CASCADE
);


-- ===== INDEXES =====
CREATE INDEX IF NOT EXISTS idx_books_category ON books(category);
CREATE INDEX IF NOT EXISTS idx_books_author ON books(author);

CREATE INDEX IF NOT EXISTS idx_members_email ON members(email);

CREATE INDEX IF NOT EXISTS idx_borrowings_book_id ON borrowings(book_id);
CREATE INDEX IF NOT EXISTS idx_borrowings_member_id ON borrowings(member_id);
CREATE INDEX IF NOT EXISTS idx_borrowings_status ON borrowings(status);


-- ===== SAMPLE DATA: Books =====
INSERT INTO books (title, author, isbn, category, total_copies, available_copies) VALUES
    ('Refactoring', 'Martin Fowler', '978-0134757599', 'Programming', 4, 4),
    ('Code Complete', 'Steve McConnell', '978-0735619678', 'Programming', 3, 3),
    ('Compilers: Principles, Techniques, and Tools', 'Aho & Ullman', '978-0321486813', 'Computer Science', 2, 2),
    ('Modern Operating Systems', 'Andrew S. Tanenbaum', '978-0133591620', 'Computer Science', 5, 4),
    ('SQL Antipatterns', 'Bill Karwin', '978-1934356555', 'Database', 2, 1),
    ('Artificial Intelligence: A Modern Approach', 'Stuart Russell', '978-0136083207', 'AI', 3, 3);

-- ===== SAMPLE DATA: Members =====
INSERT INTO members (name, email, phone, status) VALUES
    ('ชนาธิป จิตฟุ้งซ่าน', 'chanatip@email.com', '0845555555', 'active'),
    ('จิดาภา ฟ้าแจ่มใส', 'jidapa@email.com', '0644195555', 'active'),
    ('อรนุช อุดฟัน', 'oranuch@email.com', '0999999999', 'inactive');


-- ===== SAMPLE DATA: Borrowings =====
-- 1. ชนาธิป ยืม Refactoring (ยังไม่คืน)
INSERT INTO borrowings (book_id, member_id, borrow_date, due_date, status) VALUES
    (1, 1, '2026-01-01', '2026-01-15', 'borrowed');

-- 2. จิดาภา ยืม Code Complete (คืนแล้ว)
INSERT INTO borrowings (book_id, member_id, borrow_date, due_date, return_date, status) VALUES
    (3, 2, '2025-12-01', '2025-12-15', '2025-12-14', 'returned');

-- 3. อรนุช ยืม Modern Operating Systems (เกินกำหนด)
INSERT INTO borrowings (book_id, member_id, borrow_date, due_date, status) VALUES
    (5, 1, '2025-12-01', '2025-12-10', 'overdue');
