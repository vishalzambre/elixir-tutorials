# ErlectricityApp

[Reference](https://blog.fazibear.me/elixir-ruby-dont-fight-talk-with-erlectricity-dbf3af67d999#.j7pnzwrfg)

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `erlectricity_app` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:erlectricity_app, "~> 0.1.0"}]
    end
    ```

  2. Ensure `erlectricity_app` is started before your application:

    ```elixir
    def application do
      [applications: [:erlectricity_app]]
    end
    ```

 3. Run following command to start

   ```bash
   iex -S mix
   ```
