/*
  Financial Investment Game App
  Author: Madison Levine
  Date: January 2025

  Purpose:
  This app is a simulation game designed for smallholder farmers to make financial decisions
  about investments in tools like agricultural loans, drought index insurance, drought-tolerant seeds,
  and risk-contingent credit. Each stage walks the user through different tools and decisions,
  and the outcomes are calculated based on probabilistic weather and user choices.

  Project Structure:
  - lib/
    ├── main.dart                  # Entry point of the app
    ├── screens/                   # Directory for all screens
    │   ├── game_home_page.dart    # Home screen of the game
    │   ├── introduction_page.dart # Introduction screen
    │   ├── walkthrough_page.dart  # Walkthrough instructions
    │   ├── stage_one/             # Subdirectory for Stage 1
    │   │   ├── stage_one.dart     # Stage 1 main screen
    │   │   ├── round_one.dart     # Round 1 logic
    │   │   ├── fertilizer_slider.dart # Fertilizer slider logic
    │   │   ├── weather_screen.dart    # Weather calculation and display
  - assets/                        # Directory for images, sounds, and other assets
    ├── images/
    ├── sounds/

  Notes:
  - Start with `main.dart`, which initializes the app and loads the Game Home Page.
  - Navigate between screens using Flutter's Navigator.push() or pushReplacement().
  - Refer to individual files for logic specific to stages and rounds.
*/







import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(FinancialGameApp());
}

class FinancialGameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Financial Investment Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GameHomePage(),
    );
  }
}

class GameHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Financial Investment Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to the Financial Investment Game!',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => IntroductionPage()),
                );
              },
              child: Text('Start Game Introduction'),
            ),
          ],
        ),
      ),
    );
  }
}

class IntroductionPage extends StatefulWidget {
  @override
  _IntroductionPageState createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  bool buttonPressed = false; // Track button interaction for practice

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Introduction'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Introduction to the Video Game Format',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "This game will be played on a tablet, similar to how some video games work. You will be able to make decisions directly by tapping on the screen, and the game will walk you through each stage step by step. Each stage will involve making choices about different tools to manage your farm, and after each choice, the game will show you the result of your decision, such as the effect on your farm's harvest.\n\n"
                  "Don’t worry if you’re not used to using tablets or playing games – it’s designed to be simple, and we will guide you through every step.\n\n"
                  "We want you to focus on making the same kinds of decisions you would make if this were your real farm. There will be buttons to click and choices to make, but the game will explain each option clearly. There will also be someone available (the enumerator reading this to you) to help you if you are unsure about anything or need assistance navigating the game.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Practice Using the Tablet',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Here is a simple screen where you can tap a button. Please try it now to see how the tablet responds.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    buttonPressed = true;
                  });
                },
                child: Text('Tap Me!'),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                buttonPressed
                    ? 'Great! You tapped the button successfully.'
                    : '',
                style: TextStyle(fontSize: 16, color: Colors.green),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Once you feel comfortable with using the tablet, we will begin the actual game. The game is designed to simulate real-life decisions that farmers like yourself have to make when choosing innovative tools and deciding how to invest in your farm.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WalkthroughInstructions()),
                  );
                },
                child: Text('Proceed to further instructions'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WalkthroughInstructions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instructions of Game'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main Heading
            Text(
              'Walking Through the Game',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),

            // Introduction Text
            Text(
              "The game is divided into several stages, and in each stage, you will make decisions about how to run your farm. Each stage represents a different type of innovative tool that could assist with your farm, such as agricultural loans, drought index insurance, drought-tolerant seeds, or risk-contingent credit. You’ll see clear options on the screen for each decision, and you can choose by tapping on the option you prefer.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),

            // Game Breakdown (Bullet Points)
            Text(
              "General overview of the stage process:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            _buildBulletPoint("Tapping to Make Decisions: You will make choices by tapping or sliding buttons on the screen, such as deciding if you want to invest in fertilizer and the quantity you want to invest for your farm. Each option will be clearly labeled, and the game will provide explanations to help you understand what each choice means."),
            _buildBulletPoint("Seeing Results: After each decision, the game will simulate the results of your choice. For example, if you choose to take a loan and invest in fertilizer, the game will show you the quantity that you are investing, then walk you through how weather will be calculated, and show the outcome with your yields."),
            _buildBulletPoint("Repeating for Several Rounds:  Each stage consists of multiple rounds, representing different planting seasons. In each round, you’ll have the chance to make a new decision and see its results. In some stages you will have multiple modules that will restart your initial resources with a different tool where you then go through the multiple seasons of your farm again."),
            _buildBulletPoint("Random Weather: Just like real life, the weather in the game is unpredictable. The game will show you how different weather affects your crop yield and how tools like drought index insurance or drought-tolerant seeds may help during tough seasons."),
            _buildBulletPoint("Trying Different Innovative Tools: In each stage or module, you’ll try different innovative tools to see how they help you manage your farm. The game will automatically move you to the next module after you finish the rounds."),
            SizedBox(height: 16),

            // Final Notes
            Text(
              "Each stage of the game is designed to give you a new tool to use. The game is meant to be easy to follow, and there’s no right or wrong answer – the goal is to have you think about how to manage your farm and make decisions just like you would in real life.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),

            // Navigation Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StageOne()),
                  );
                },
                child: Text('Start Stage 1'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper Function for Bullet Points
  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "\u2022", // Bullet point character
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
class StageOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stage 1: Practice Agricultural Loan'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Text
            Text(
              'Stage 1: Agricultural Loan and Fertilizer Investment',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),

            // Instruction Text
            // TODO: I need to settle on an amount of land that would be suitable for the farmers that is not unrealistic.
            // TODO: Then, this land needs to be split in a portion that they can start out with for seeds planting wise that they can grow to use the rest of the land if their outcomes are favorable.
            // TODO: Need to add in the amount that we will want for the loan, and decide on a loan interest rate. Right now I will keep this for calculations to be 5%.
            Text(
              'In this first stage of the game, you will be managing your farm for four seasons. You have XX amount of land, and XX seeds. This means your seeds can cover about 1/3 of the land in the very first season.\n\n\nEach season, the innovative tool you have access to is an agricultural loan. This agricultural loan can only be used to purchase fertilizer for the seeds you plant each season.\n\n\nThe loan amount is fixed, and will have an interest rate of 5% that will be added to the loan amount to be paid back after the harvest.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'For the first two rounds, you are required to take out this agricultural loan, which can only be used to buy fertilizer for your crops. After the first two rounds, you’ll be able to decide whether or not you want to continue using the loan to support your farm. The goal is to see how different decisions affect your farm’s success.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),

            // Button to Proceed to Round 1
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to Round 1
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RoundOne()),
                  );
                },
                child: Text('Proceed to Round 1'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class RoundOne extends StatefulWidget {
  @override
  _RoundOneState createState() => _RoundOneState();
}

class _RoundOneState extends State<RoundOne> {
  bool loanAcknowledged = false; // Tracks if loan is acknowledged
  bool investInFertilizer = false; // Tracks fertilizer investment decision
  double fertilizerUsed = 0; // Tracks slider value
  String weatherOutcome = ""; // Tracks weather outcome

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Round 1: Agricultural Loan'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Step 1: Starting the round
            Text(
              'Welcome to Round 1',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'You have XX amount of land, XX seeds, and no fertilizer. You are required to take an agricultural loan for 100 units of fertilizer.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),

            // Step 2: Acknowledge the loan
            if (!loanAcknowledged) ...[
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    loanAcknowledged = true;
                  });
                },
                child: Text('I understand I am taking out an agricultural loan'),
              ),
            ] else ...[
              // Step 3: Decide to invest in fertilizer
              Text(
                'Would you like to invest in fertilizer for this round?',
                style: TextStyle(fontSize: 16),
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to Fertilizer Slider Screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FertilizerSliderScreen()),
                      );
                    },
                    child: Text('Yes'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to Weather Screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WeatherScreen()),
                      );
                    },
                    child: Text('No'),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
class FertilizerSliderScreen extends StatefulWidget {
  @override
  _FertilizerSliderScreenState createState() => _FertilizerSliderScreenState();
}

class _FertilizerSliderScreenState extends State<FertilizerSliderScreen> {
  double fertilizerUsed = 0; // Tracks slider value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fertilizer Slider'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Slide to decide how much fertilizer to use (0-100 units).',
              style: TextStyle(fontSize: 16),
            ),
            Slider(
              value: fertilizerUsed,
              min: 0,
              max: 100,
              divisions: 100,
              label: fertilizerUsed.toStringAsFixed(0),
              onChanged: (value) {
                setState(() {
                  fertilizerUsed = value;
                });
              },
            ),
            SizedBox(height: 16),
            Text(
              'You decided to use ${fertilizerUsed.toStringAsFixed(0)} units of fertilizer.\n'
                  'This allocates ${fertilizerUsed * 0.05} of the loan amount and leaves ${(100 - fertilizerUsed) * 0.05} remaining.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to the weather screen after confirming
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WeatherScreen()),
                  );
                },
                child: Text('Proceed to Weather Outcome'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class WeatherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Outcome'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'This is where the weather outcome will be displayed.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Navigate to the next round or summary
                Navigator.pop(context);
              },
              child: Text('Proceed to Next Round'),
            ),
          ],
        ),
      ),
    );
  }
}
