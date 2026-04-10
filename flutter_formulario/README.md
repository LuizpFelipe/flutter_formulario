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

### Funcionalidades:
* **Criar:** Cadastro de nova transação (Título, Valor e Data) via formulário.
* **Ler:** Listagem de despesas persistidas no backend e exibição de gráfico semanal.
* **Atualizar:** Possibilidade de edição de registros existentes.
* **Excluir:** Remoção de transações com atualização em tempo real do estado.

---

### Estrutura de Pastas:
```text
lib/
├── models/         # Classe Transacao com fromJson e toJson
├── services/       # TransacaoService usando Dio
├── providers/      # TransacaoProvider (Lógica de negócio e estado)
├── ui/
│   ├── screens/    # Telas (TransactionScreen)
│   └── widgets/    # Componentes (Chart, ChartBar, Form, List)
└── main.dart       # Configuração de rotas e injeção de dependência