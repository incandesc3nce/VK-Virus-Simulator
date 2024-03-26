# Симулятор распространения вируса

### Архитектура - MVC
### Стэк - Swift, UIKit

Данное приложение было сделано в качестве тестового задания для VK.

При запуске приложения, пользователя просят ввести данные, необходимые для симуляции модели распространения вируса.
Этими данными являются количество людей в группе, количество людей, которое может заразить один зараженный человек при контакте с ними, и период за который выполняется пересчет 
модели.

<img width="400" src="https://github.com/incandesc3nce/VK-Virus-Simulator/assets/62383010/b1e2c49d-b647-4f0f-b193-684a66e149ba">
<img width="400" src="https://github.com/incandesc3nce/VK-Virus-Simulator/assets/62383010/abcd69cc-1dd5-4906-8a86-4a3ed48a5bcb">

После ввода данных пользователя направляют на экран с симуляцией модели. Изначально все элементы модели здоровые.

<img width="400" src="https://github.com/incandesc3nce/VK-Virus-Simulator/assets/62383010/2b083a9b-01a9-4fa5-a49a-7771a8df9186">

Пользователь может сам выбрать с какого элемента начать распространение инфекции и в дальнейшем выбирать элементы, которые он хочет заразить.

Демонстрация работы симуляции (размер группы = 1000, заражений при контакте = 3, период = 0.7):

![Simulator Screen Recording - iPhone 15 Pro Max - 2024-03-26 at 21 23 05](https://github.com/incandesc3nce/VK-Virus-Simulator/assets/62383010/395cd359-ece0-4535-90f0-5e0f7308e157)
