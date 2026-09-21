# NostraTest — iOS Technical Test (Sept 2026)

Mini-app "e-Catalog" menampilkan daftar produk + detail, data diambil dari (https://dummyjson.com/products) dibangun dengan UIKit programmatic (MVVM + Clean Architecture).

## Requirement

- Design pattern: MVVM + Clean Architecture
- UI programmatic (Auto Layout, tanpa Storyboard untuk layar aplikasi)
- HTTP request via URLSession (async/await)
- List menampilkan 3 state: loading, error, empty
- Git history, folder `.git` disertakan
- Project bisa di-build & run di simulator
- Minimum deployment target iOS 15.0

## Cara Build & Menjalankan

1. Buka NostraTest.xcodeproj di Xcode.
2. Pilih simulator
3. Jalankan dengan Command + R.

## Yang Belum Selesai / Sengaja Di-skip

Saya baru sekitar 2 minggu ini transisi dari Flutter ke native iOS, jadi fokus saya di requirement wajib + cache sederhana dulu. Untuk requirement bonus (multi-environment build, unit test XCTest, archive per environment), saya belum sempat pelajari dokumentasi resminya secara mendalam. Dan akan jadi prioritas belajar saya berikutnya.

Estimasi total waktu pengerjaan: ± 1 - 2 hari kerja.
