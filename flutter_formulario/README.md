# 💰 App Despesas Pessoais - CRUD Flutter

Trabalho Bimestral da disciplina de **Programação para Dispositivos Móveis**. O objetivo é demonstrar a implementação de um CRUD completo consumindo uma API REST, seguindo a arquitetura Service-Provider-UI.

---

## 👥 Integrantes e Turma
* **Diogo Assis** (RA: 226188-2024)
* **Luiz Felipe** (RA: 347395-2025)
* **Turma:** 4º Ano - Engenharia de Software

---

## 📱 Sobre o Aplicativo
O aplicativo é uma ferramenta de **Controle Financeiro** que permite ao usuário gerenciar suas despesas diárias. Além de listar e cadastrar transações, o app exibe um gráfico dinâmico dos gastos realizados nos últimos 7 dias.

### Funcionalidades (CRUD):
* **Create:** Cadastro de nova transação via modal (POST).
* **Read:** Listagem de despesas e gráfico dinâmico sincronizado (GET).
* **Update:** Edição de registros existentes (PATCH/PUT).
* **Delete:** Remoção de transações com atualização reativa (DELETE).

---

## 🛠️ Tecnologias e Arquitetura
O projeto foi refatorado para seguir os padrões modernos de desenvolvimento profissional em Flutter:
* **Gerenciamento de Estado:** `Provider` (para uma interface reativa e desacoplada).
* **Navegação:** `GoRouter` (gerenciamento de rotas declarativas).
* **Cliente HTTP:** `Dio` (com tratamento de requisições assíncronas).
* **Backend:** API REST hospedada no Railway.

---

## 🚀 Passo a Passo para Execução

Siga rigorosamente os passos abaixo para compilar e rodar o projeto em sua máquina:

### 1. Pré-requisitos
* Ter o **Flutter SDK** instalado (versão estável 3.x ou superior).
* Git instalado para clonagem.
* Um emulador (Android/iOS), dispositivo físico ou navegador Chrome.

### 2. Clonar o Repositório
Abra o seu terminal e execute:
```bash
git clone [https://github.com/LuizpFelipe/flutter_formulario.git](https://github.com/LuizpFelipe/flutter_formulario.git)
cd flutter_formulario