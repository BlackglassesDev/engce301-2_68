// นำเข้า Express
const express = require('express');

// สร้าง Application
const app = express();

// กำหนด Port
const PORT = 3000;

// สร้าง Route แรก
app.get('/', (req, res) => {
  res.send('Hello World from Express! 🚀');
});

// GET - ดึงรายการทั้งหมด
app.get('/api/products', (req, res) => {
  res.json({ 
    message: 'Get all products',
    data: []
  });
});

// GET - ดึงรายการเดียวตาม ID
app.get('/api/products/:id', (req, res) => {
  const id = req.params.id;
  res.json({ 
    message: `Get product with ID: ${id}`,
    data: { id: id, name: 'Sample Product' }
  });
});

// POST - สร้างรายการใหม่
app.post('/api/products', (req, res) => {
  res.json({ 
    message: 'Create new product',
    status: 'success'
  });
});

// PUT - อัปเดตรายการ
app.put('/api/products/:id', (req, res) => {
  const id = req.params.id;
  res.json({ 
    message: `Update product with ID: ${id}`,
    status: 'success'
  });
});

// DELETE - ลบรายการ
app.delete('/api/products/:id', (req, res) => {
  const id = req.params.id;
  res.json({ 
    message: `Delete product with ID: ${id}`,
    status: 'success'
  });
});

// เริ่ม Server
app.listen(PORT, () => {
  console.log(`✅ Server is running on http://localhost:${PORT}`);
});