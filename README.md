# MetaEvents

Um experimento usando a metaprogramação do elixir junto com genservers

## Objetivos

[x] Criar módulos que representam eventos
[x] Criar um genserver capaz de receber requisições e discernir o módulo e o evento que é necessário chamar
[x] Persistir o resultado dos eventos em um banco de dados
[x] Criar um vigia de eventos que engatilha outros eventos

## Como rodar

1. Clone o projeto
2. Crie o banco de dados: `mix setup`
3. Rode com iex: `iex -S mix`
4. Teste emitindo um evento:

    ```elixir
    MetaEvents.EventBroker.Client.emmit_event(%{
        name: "Hello", 
        payload: %{message: "Hello, my name is: "}, 
        emmiter: "guilherme"
    })
    ```

## Como criar os seus eventos

1. Crie um arquivo `./lib/meta_events/modules/meu_event.ex`
2. Adicione `@behaviour EventBehaviour`
3. Crie a sua função `call/2` (para mais informações use no `iex`: `b EventBehaviour`)

## Como criar seus ouvidores (`Listeners`)

1. Crie um arquivo `lib/meta_events/modules/meu_listener.ex`
2. Adicione `@behaviour ListenerBehaviour`
3. Crie as funções `call/1` e `listen?/1` (para mais informações use no `iex`: `b ListenerBehaviour`)
