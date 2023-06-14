# Event Description Generator

This Flutter application generates creative event descriptions using the ChatGPT API. It allows event organizers to provide event details and receive a creative description for their events.

## Features

- Connects with the ChatGPT API to generate event descriptions.
- Supports customization of event details such as name, date, time, location, speaker, category, ticket price, and additional information.
- Provides a user-friendly interface for entering event details and displaying the generated event description.

## Screenshots

![Screenshot (370)](https://github.com/dhruv2x/event_description_generator/assets/84621641/298ee935-6900-4394-8ad1-7eb02aaa653e)


## Getting Started

To run the application locally, follow these steps:

1. Clone the repository:

```shell
git clone https://github.com/your-username/event-description-generator.git
```

2. Navigate to the project directory:

```shell
cd event-description-generator
```

3. Install the dependencies:

```shell
flutter pub get
```

4. Run the application:

```shell
flutter run
```

## Configuration

To use the ChatGPT API and generate event descriptions, you need to provide your API key. Follow these steps to set up the API key:

1. Obtain an API key from OpenAI by signing up for the ChatGPT API.
2. Open the `lib/main.dart` file.
3. Replace `'YOUR_API_KEY'` with your actual API key in the `sendMessageToChatGpt` method.

```dart
String apiKey = 'YOUR_API_KEY';
```

## Contributing

Contributions are welcome! If you have any ideas, suggestions, or bug reports, please open an issue or submit a pull request.

## License

This project is licensed under the [MIT License](LICENSE).
```

In this README.md file, you can customize the sections as per your project requirements. Provide an overview of your project, its features, and how to get started with running the application locally. You can also include screenshots to showcase the application's UI.

Additionally, mention any configuration steps required, such as setting up API keys or environment variables. Encourage contributions from the community and specify the license under which the project is released.

Feel free to modify the template to suit your project's specific needs.
