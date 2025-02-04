# Ko_dig4loot

Overview:
The Dig4Loot script allows players to engage in a digging mechanic in-game, where they can dig at specific locations and receive random loot rewards. The script also integrates with Discord for event logging and can be fully customized via a configuration file.

Features:
Digging Locations:
Players must be within a specified area (set in the Config.DiggingLocations) to begin the digging process. The areas can be easily customized in the configuration file.

Progress Circle:
A visual progress circle is displayed while the player is digging. The progress circle indicates the time it takes to complete the digging action (default: 5 seconds). Players can cancel the action before it’s finished.

Loot Rewards:
Upon successful completion of the digging task, the player is rewarded with a random item from a defined loot pool. The rewards are divided into tiers, and the script randomly selects a reward from the relevant tier.

Discord Logging:
The script can log events to a Discord webhook, including when a player digs and what reward they receive, for tracking and moderation purposes.
