// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GenerateNextSave extends Equatable {
  @override
  List<Object?> get props => [];

  //  Generating the init takes the place of "generate next save".
  //  It plugs into the generateNextSave logic in order to populate database.
  generateNextInit(currentSource) async {
    /*
    try {
      final _firestore = FirebaseFirestore.instance;
      await _firestore.collection('source').add({
        'sourceName': currentSource.sourceName,
        'sourceText': currentSource.sourceType
      });
      return 'Saved!';
    } catch (e) {
      print(e);
    }
     */
    List<List> listOfAllRules = [
      [
        'Sylvaneth Wyldwood',
        'Sylvaneth',
        'Allegiance ability',
        'Sylvaneth',
        'After territories chosen before armies deployed set up the Wyldwood anywhere further than 1 inch from enemy territory and from other terrain more than 6 inches from objectives.',
        'turn'
      ],
      [
        'Roused by Magic',
        'Sylvaneth',
        'Allegiance ability',
        'Sylvaneth',
        'If wizard successfully casts spell wholly within 6 inches not unbound: roll 1 die for each non-Sylvaneth unit within 1 inch of Wyldwood. 5+ they take d3 mortal wounds after spell effect.',
        'turn'
      ],
      [
        'Ultimate Sacrifice',
        'Druanti Arch-Revenant',
        'Unit ability',
        'Sylvaneth',
        'Once per battle Druanti Arch-Revenant when you allocate a wound or mortal wound to this model you may negate it. If so cannot fly or use Tail attack for rest of battle.',
        'turn'
      ],
      [
        'Blessings of the Forest',
        'Dryads',
        'Unit ability',
        'Sylvaneth',
        'Dryads if wholly within 6 inches of Wyldwood -1 from hit rolls that target them.',
        'turn'
      ],
      [
        'Envoys of the Everqueen',
        'Kurnoth Hunters',
        'Unit ability',
        'Sylvaneth',
        'Kurnoth Hunters extend Sylvaneth Hero command abilities to within 12 inches of this unit.',
        'turn'
      ],
      [
        'My Heart is Ice',
        'My Heart is Ice',
        'Command Trait',
        'Sylvaneth',
        'When your general takes a wound from melee attack roll a die and on a 5+ deal a mortal wound back.',
        'combat'
      ],
      [
        'Legacy of Valor',
        'Legacy of Valor',
        'Command Trait',
        'Sylvaneth',
        'If your General is slain pick an enemy unit within 1 inch and roll a die. On a 2-5 that unit suffers D3 mortal wounds and on a 6 it suffers D6.',
        'turn'
      ],
      [
        'Masters of the Hunt',
        'Heartwood',
        'Subfaction ability',
        'Sylvaneth',
        'Pick 3 enemy units after deployment. You get +1 to hit against them.',
        'turn'
      ],
      [
        'Blessing of the Heartwood',
        'Heartwood',
        'Battalion ability',
        'Sylvaneth',
        'During each Hero phase the Branchwych and Treelord heal one wound lost earlier whilst the Dryads add 1 model to their unit that was lost earlier.',
        'turn'
      ],
      [
        'Mystic Shield',
        'general',
        'Magic Spell',
        'any',
        'Casting value: 6 Range 18 inches. Re-roll save rolls of 1 until the next Hero phase.',
        'hero'
      ],
      [
        'Verdant Blessing',
        'Sylvaneth',
        'Magic Spell',
        'Sylvaneth',
        'Casting value: 6 Set up a new Sylvaneth Wyldwood 18 inches away from the caster and not within 1 inch of any other model or terrain.',
        'hero'
      ],
      [
        'Forward to Victory',
        'general',
        'Command ability',
        'any',
        'CP -within 6 inches or 12 inches of general re-roll charge roll.',
        'hero'
      ],
      [
        'All out Attack',
        'general',
        'Command ability',
        'any',
        'CP -within 12 inches or 18 inches of general re-roll hits of 1 in combat.',
        'hero'
      ],
      [
        'Volley Fire',
        'general',
        'Command ability',
        'any',
        'CP -within 12 inches or 18 inches of general re-roll hits of 1 in shooting.',
        'hero'
      ],
      [
        'Acorn of the Ages',
        'Acorn of the Ages',
        'Artifact',
        'Sylvaneth',
        'Once per battle at the start of the Hero phase set up a Wyldwood wholly within 12 inches and more than 1 inch away from enemies or terrain',
        'hero'
      ],
      [
        'Retreat',
        'general',
        'turn',
        'any',
        'Units starting movement phase within 3 inches of enemy can retreat. The unit must end move more than 3 inches away from enemy and cant shoot or charge later that turn.',
        'move'
      ],
      [
        'Swift as the Breeze',
        'Forest Folk',
        'Battalion ability',
        'Sylvaneth',
        'Units from the Forest Folk battalion can retreat and still charge in the same turn.',
        'move'
      ],
      [
        'Close Shoot',
        'general',
        'turn',
        'any',
        'If an enemy is within 3 inches you must target that unit if possible',
        'move'
      ],
      [
        'Branch Blizzard',
        'Winterleaf',
        'Command ability',
        'Sylvaneth',
        'CP -pick an enemy unit within 12 inches of a friendly hero- roll a die for each model each 6 is a mortal wound.',
        'shoot'
      ],
      [
        'Death from Above',
        'Khinerai Heartrenders',
        'Unit ability',
        'Sylvaneth',
        'Khinerai Heartrenders can shoot even if they ran. On same turn as setting up javelins have -2 rend shooting for that turn.',
        'shoot'
      ],
      [
        'Charge Roll',
        'general',
        'turn',
        'any',
        'Charge range 2D6 inches',
        'charge'
      ],
      [
        'Tanglethorn Thicket',
        'Kurnoth Hunters',
        'Unit ability',
        'Sylvaneth',
        'Kurnoth Hunters in Charge phase can choose to only pile in 1 inch in order to reroll Sv rolls for the following Combat phase.',
        'charge'
      ],
      [
        'Pile In',
        'general',
        'turn',
        'any',
        'The unit chosen piles in 3 inches and fights',
        'combat'
      ],
      [
        'Frozen Kernel',
        'Frozen Kernel',
        'Artifact',
        'Sylvaneth',
        'Once per battle at start of combat pick 1 Winterleaf unit wholly within 18 inches of bearer. After fighting that unit can pile in and fight a second time if within 3 inches of an enemy.',
        'combat'
      ],
      [
        'Ground Shaking Stomp',
        'Treelord',
        'Unit ability',
        'Sylvaneth',
        'Start of combat Treelord pick 1 enemy unit within 3 inches. On 4+ that unit goes last in phase.',
        'combat'
      ],
      [
        'Call to Battle',
        'Druanti Arch-Revenant',
        'Command ability',
        'Sylvaneth',
        'Start of Combat phase Druanti Arch-Revenant CP -pick a friendly Sylvaneth unit wholly within 9 inches or 12 inches if general. Add 1 to the attacks characteristic of their melee weapons in that phase.',
        'combat'
      ],
      [
        'Winters Bite',
        'Winterleaf',
        'Subfaction ability',
        'Sylvaneth',
        'If unmodified melee hit roll for Winterleaf unit is 6 inflicts two hits instead of 1.',
        'combat'
      ],
      [
        'Horn of the Consort',
        'Heartwood',
        'Artifact',
        'Sylvaneth',
        'Reroll hit rolls for Kurnoth Hunters wholly within 12 inches of bearer.',
        'combat'
      ],
      [
        'Quick Tempered',
        'Branchwych',
        'Unit ability',
        'Sylvaneth',
        'Branchwych +2 attacks with Scythe while wounded.',
        'combat'
      ],
      [
        'Heartpiercer Shield',
        'Khinerai Heartrenders',
        'Unit ability',
        'Sylvaneth',
        'Khinerai Heartrenders in Combat phase have save of 5+. Each time you save on an unmodified 6 deal 1 mortal wound to attacker after combat.',
        'combat'
      ],
      [
        'Battleshock',
        'general',
        'turn',
        'any',
        'If a unit lost models this turn roll a die. Add 1 for each model slain this turn subtract 1 for each 10 models remaining. If roll is greater than bravery lose 1 model for each point',
        'combat'
      ],
      [
        'Waystone Wanderers',
        'Waystone Pathfinders',
        'Battalion ability',
        'Wood Aelves',
        'You may hold your units back from deployment and set your units up along any table edge more than 9 inches from the enemy in the first Movement phase.',
        'battleshock'
      ],
      [
        'Deepwood Shield',
        'Nomad Prince',
        'Unit ability',
        'Wood Aelves',
        'Nomad Prince reroll failed save rolls.',
        'turn'
      ],
      [
        'Invisible Hunter',
        'Waywatcher',
        'Unit ability',
        'Wood Aelves',
        'Waywatcher -1 to hit rolls made against this target in Shooting phase.',
        'turn'
      ],
      [
        'Forget-me-Knot',
        'Forget-me-Knot',
        'Artifact',
        'Wood Aelves',
        'Once per battle in any Combat phase pick an enemy hero within 3 inches of this model. That hero may not pile in attack or use any abilities this phase.',
        'turn'
      ],
      [
        'Sisters of the Thorn',
        'Sisters of the Thorn',
        'Unit ability',
        'Wood Aelves',
        'Sisters of the Thorn: If 2 or more counts as Wizard with 1 unbind Arcane Bolt Mystic Shield Armor of Thorns.',
        'hero'
      ],
      [
        'Ancient Blessings',
        'Spellweaver',
        'Unit ability',
        'Wood Aelves',
        'Spellweaver once per game can automatically unbind a spell.',
        'hero'
      ],
      [
        'See But Do Not Be Seen',
        'Waywatcher',
        'Command ability',
        'Wood Aelves',
        'CP -Until next Hero phase all Wood Aelves within 18 inches gain Invisible Hunter.',
        'hero'
      ],
      [
        'Realm Wanderers',
        'Wood Aelves',
        'Allegiance ability',
        'Wood Aelves',
        'At the start of your Movement phase one Wood Aelf unit within 6 inches of a table edge can be removed and set up anywhere wholly within 6 inches of the same table edge more than 9 inches from the enemy. This counts as their movement.',
        'hero'
      ],
      [
        'Stalker of the Hidden Paths',
        'Stalker of the Hidden Paths',
        'Command Trait',
        'Wood Aelves',
        'If a friendly Wood Aelf unit that is wholly within 12 inches of the general leaves the battlefield using the Realm Wanderers ability then it can return wholly within 6 inches of any table edge.',
        'move'
      ],
      [
        'Solitary Marksman',
        'Waywatcher',
        'Unit ability',
        'Wood Aelves',
        'Waywatcher can sacrifice move for +1 to shooting hit rolls for that turn.',
        'move'
      ],
      [
        'Arcane Bodkins',
        'Glade Guard',
        'Unit ability',
        'Wood Aelves',
        'Once per game fire enchanted arrows -3 enemy Sv for that phase.',
        'shoot'
      ],
      [
        'Masterful Hunter',
        'Masterful Hunter',
        'Command Trait',
        'Wood Aelves',
        'Add 1 to the generals hit rolls for attacks he makes with a missile weapon. If he does not have one then they receive a hunting hawk just like the Nomad Prince.',
        'shoot'
      ],
      [
        'Eye Thief',
        'Nomad Prince',
        'Unit ability',
        'Wood Aelves',
        'Nomad Prince any wounds caused by Hawk -1 to hit rolls by wounded model.',
        'shoot'
      ],
      [
        'Fast Shots',
        'Waywatcher',
        'Unit ability',
        'Wood Aelves',
        'Waywatcher +3 attacks each 6 to hit generates an additional attack.',
        'shoot'
      ],
      [
        'Starcaster Longbow',
        'Starcaster Longbow',
        'Artifact',
        'Wood Aelves',
        'In your Shooting phase pick a unit within 20 inches and roll a die. On a 2+ mortal wound on a 6 they take D3.',
        'shoot'
      ],
      [
        'Loose Until the Last',
        'Sisters of the Watch',
        'Unit ability',
        'Wood Aelves',
        'Sisters of the Watch once per turn if enemy ends charge within 3 inches  and no other enemies within 3 inches can shoot.',
        'charge'
      ],
      [
        'Trample Underfoot',
        'Kurnoth Hunters',
        'Unit ability',
        'Sylvaneth',
        'At end of combat pick 1 enemy unit within 1 inch and roll 1 die for each Hunter. 4+ for mortal wound.',
        'charge'
      ],
      [
        'Defiant Hunters',
        'Wood Aelves',
        'Allegiance ability',
        'Wood Aelves',
        'You may reroll battleshock tests for Wood Aelf units.',
        'combat'
      ],
      [
        'Always Take What You Are Owed',
        'Barak-Urbaz',
        'Subfaction Ability',
        'Kharadron Overlords',
        'At the start of battle up to d3 Barak-Urbaz units start with an extra aether-gold.',
        'turn'
      ],
      [
        'Magnificent Skyvessels',
        'Barak-Zilfin',
        'Subfaction Ability',
        'Kharadron Overlords',
        '1 extra Skyvessel in your army can have a great endrinwork.',
        'turn'
      ],
      [
        'Atmospheric Isolation',
        'Aether-Khemist',
        'Unit ability',
        'Kharadron Overlords',
        '-1 from hit rolls made by enemy models while within 3 inches. Cannot be used from garrison.',
        'turn'
      ],
      [
        'Choking Fug',
        'Grundstock Thunderers',
        'Unit ability',
        'Kharadron Overlords',
        'Grundstock Thunderers -1 from hit rolls for attacks by enemies within 3 inches of Fumigator. Cannot be used while garrisoned.',
        'turn'
      ],
      [
        'Aethercharged Rune',
        'Aethercharged Rune',
        'Artifact',
        'Kharadron Overlords',
        'Once per battle you can change either 1 hit roll for an attack made by the bearer or 1 save roll for an attack that targets the bearer to the roll of your choice.',
        'turn'
      ],
      [
        'Staff of Ocular Optimisation',
        'Staff of Ocular Optimisation',
        'Artifact',
        'Kharadron Overlords',
        'Pick 1 of the bearers missile weapons. Add 1 to hit rolls for that weapon.',
        'shoot'
      ],
      [
        'Breath of Morgrim',
        'Breath of Morgrim',
        'Artifact',
        'Kharadron Overlords',
        'You can pick 1 enemy unit and roll 1 die for each model from that unit within 6 inches of the bearer. Each 6 deals 1 mortal wound.',
        'shoot'
      ],
      [
        'Endrinmaster',
        'Endrinmaster',
        'Unit ability',
        'Kharadron Overlords',
        'Endrinmaster at start of Hero phase pick 1 Skyvessel within 1 inch it heals 3 wounds.',
        'hero'
      ],
      [
        'Aetheric Navigator and Endrinrigger',
        'Arkanaut Frigate',
        'Unit ability',
        'Kharadron Overlords',
        'Arkanaut Frigate in Hero phase heal 1 wound.',
        'hero'
      ],
      [
        'Trust Aethermatics Not Superstition',
        'Barak-Nar',
        'Subfaction ability',
        'Kharadron Overlords',
        'Each Barak-Nar Hero can unbind a spell in the enemy Hero phase. If they already can they can unbind 2.',
        'hero'
      ],
      [
        'Aetheric Augmentation',
        'Aether-Khemist',
        'Unit ability',
        'Kharadron Overlords',
        'Aether Khemist may pick 1 friendly Skyfarers unit wholly within 12". Until your next Hero phase reroll wound rolls of 1 for attacks made by that unit. Cannot be used while garrisoned.',
        'hero'
      ],
      [
        'Dont Argue With the Wind',
        'Barak-Zilfin',
        'Subfaction Ability',
        'Kharadron Overlords',
        'If you declare a run for Barak-Zilfin units it is always 6 inches.',
        'hero'
      ],
      [
        'Fly High',
        'Arkanaut Frigate',
        'Unit ability',
        'Kharadron Overlords',
        'Frigate if less than 7 wounds allocated instead of normal move may redeploy anywhere more than 1 inch from terrain and 9 inches from enemy.',
        'move'
      ],
      [
        'Timed Charges',
        'Skywardens',
        'Unit ability',
        'Kharadron Overlords',
        'Skywardens roll a die for each enemy unit within 3 inches immediately before this unit retreats. 4+ for d3 mortal wounds.',
        'move'
      ],
      [
        'Focused Fire',
        'Grundstock Escort Wing',
        'Battalion ability',
        'Kharadron Overlords',
        'At start of Shooting phase pick 1 enemy unit for this battalion to focus on. Reroll hit rolls of 1 for this battalion against that unit for that phase.',
        'move'
      ],
      [
        'Pin Them Shred Them Finish Them',
        'Grundstock Thunderers',
        'Unit ability',
        'Kharadron Overlords',
        'Grundstock Thunderers if you have one each of mortar sweeper and cannon +1 to hit rolls for their attacks. Cannot be used while garrisoned',
        'shoot'
      ],
      [
        'Master the Skies',
        'Barak-Zilfin',
        'Subfaction Ability',
        'Kharadron Overlords',
        'Reroll hit rolls of 1 for Skyvessels targeting a flying unit.',
        'shoot'
      ],
      [
        'Skymines',
        'Skywardens',
        'Unit ability',
        'Kharadron Overlords',
        'If enemy flier ends charge within 1 inch roll a die for each model in that unit. 6 for mortal wound.',
        'shoot'
      ],
      [
        'Where Theres War Theres Gold',
        'Barak-Urbaz',
        'Subfaction Ability',
        'Kharadron Overlords',
        'Once per battle at end of Combat phase 1 Skyfarers unit that fought gains 1 aether-gold.',
        'charge'
      ],
      [
        'Bomb Racks',
        'Arkanaut Frigate',
        'Unit ability',
        'Kharadron Overlords',
        'Frigate at start of Combat phase pick 1 enemy unit within 1 inch and roll a die. Add modifier from table. 4+ for d3 mortal wounds.',
        'combat'
      ],
      [
        'Master Commander',
        'Master Commander',
        'Command Trait',
        'Kharadron Overlords',
        'If your general is alive and on the battlefield each time you spend a command point on a command ability on the Admiral’s warscroll on a 5+ receive 1 extra command point.',
        'hero'
      ],
      [
        'Khemist Supreme',
        'Khemist Supreme',
        'Command Trait',
        'Kharadron Overlords',
        'Aetheric Augmentation ability can now affect 2 units a turn rather than 1.',
        'hero'
      ],
      [
        'Champion of Progress',
        'Champion of Progress',
        'Command Trait',
        'Kharadron Overlords',
        'Endrinmaster do not take battleshock for Barak-Nar units wholly within 12 inches of this general.',
        'battleshock'
      ],
      [
        'Seek New Prospects',
        'Barak-Urbaz',
        'Subfaction Ability',
        'Kharadron Overlords',
        'Reroll battleshock for Barak-Urbaz units wholly within opponents territory.',
        'battleshock'
      ],
      [
        'Locus of Fury',
        'Blades of Khorne',
        'Allegiance ability',
        'Blades of Khorne',
        'All friendly Deamons reroll hit rolls of 1 when within 12 inches of Deamon Hero of 18 inches of Greater Deamon.',
        'battleshock'
      ],
      [
        'Chaos Rune Shield',
        'Chaos Lord on Manticore',
        'Unit ability',
        'Blades of Khorne',
        '5+ to ignore any mortal wound.',
        'turn'
      ],
      [
        'Prey of the Blood God',
        'Karanak',
        'Unit ability',
        'Blades of Khorne',
        'After setup nominate an enemy Hero as Quarry. Karanak rerolls hit and wound against it.',
        'turn'
      ],
      [
        'Slay the Mighty',
        'Bloodlords',
        'Allegiance ability',
        'Blades of Khorne',
        'Reroll wound rolls of 1 for Bloodlords Deamon units targeting a Hero or Monster.',
        'turn'
      ],
      [
        'Drawn in for the Kill',
        'Bloodthirster of Unfettered Fury',
        'Unit ability',
        'Blades of Khorne',
        'Bloodthirster of Unfettered Fury at the start of enemy movement phase pick an enemy unit within 3 inches. It cannot retreat.',
        'turn'
      ],
      [
        'The Land Rebels',
        'Bloodthirster of Unfettered Fury',
        'Unit ability',
        'Blades of Khorne',
        'Bloodthirster of Unfettered Fury start of Hero phase roll 1 die for each enemy unit wholly within 8 inches. 5+ for a mortal wound.',
        'hero'
      ],
      [
        'Brass Collar of Bloody Vengeance',
        'Karanak',
        'Unit ability',
        'Blades of Khorne',
        'Karanak can unbind/dispel one spell if successful causes D3 mortal wounds.',
        'hero'
      ],
      [
        'Mage Eater',
        'Mage Eater',
        'Command Trait',
        'Blades of Khorne',
        'General can unbind 1 spell. If the roll is an 8 automatic success and caster suffers d6 mortal wounds.',
        'hero'
      ],
      [
        'Bronzed Flesh',
        'Slaughterpriest',
        'Unit ability',
        'Blades of Khorne',
        'Priest 4+ success 1 1mortal wound. Pick either the priest or Khorne unit from your army wholly within 16 inches. +1 to save rolls until your next hero phase.',
        'hero'
      ],
      [
        'Bloodboil',
        'Slaughterpriest',
        'Unit ability',
        'Blades of Khorne',
        'Priest 4+ success 1 take D3 mortal wounds. 1 unit within 16 inches suffers D6 mortal wounds.',
        'hero'
      ],
      [
        'Bleeding Icon',
        'Bleeding Icon',
        'Unit ability',
        'Blades of Khorne',
        'CV 4+ Set up wholly within 8 inches of priest. May move up to eight inches in your hero phase (and immediately after being summoned)',
        ". D3 mortal wounds to any unit it passes over or lands within 3 inches of. Adds +d3 casualties to any failed battleshock tests within 3 inches.'",
        'hero'
      ],
      [
        'Slaughterers Thirst',
        'Slaughterers Thirst',
        'Command Trait',
        'Blades of Khorne',
        '+4 to Move characteristic of general. Reroll charge rolls for general.',
        'hero'
      ],
      [
        'Bloodsoaked Banner',
        'Bloodletters',
        'Unit ability',
        'Blades of Khorne',
        'Bloodletters re-roll charge rolls.',
        'charge'
      ],
      [
        'Cometh the Slaughter',
        'Blood Host',
        'Battalion ability',
        'Blades of Khorne',
        'Reroll charge rolls for units in this battalion while wholly within 16 inches of Bloodthirster from same battalion.',
        'charge'
      ],
      [
        'Leave None Alive',
        'Reapers of Vengeance',
        'Command ability',
        'Blades of Khorne',
        'CP -start of Combat phase. Pick 1 Reapers of Vengeance Deamon unit wholly within 8 inches of model with this command ability. After that unit has fought if within 3 inches of an enemy can pile in and attack again.',
        'combat'
      ],
      [
        'Rejoice in the Slaughter',
        'Bloodthirster of Unfettered Fury',
        'Command ability',
        'Blades of Khorne',
        'CP -start of Combat phase. Bloodthirster of Unfettered Fury until end of phase friendly Khorne Deamon units wholly within 16 inches are eligible to fight if 6 inches from enemies and can pile in extra 3 inches.',
        'combat'
      ],
      [
        'The Blood Must Flow',
        'Herald of Khorne',
        'Unit ability',
        'Blades of Khorne',
        'After fighting in combat pick 1 Bloodletter unit wholly within 12 inches which has not fought yet. They fight immediately.',
        'combat'
      ],
      [
        'Gorecleaver',
        'Gorecleaver',
        'Artifact',
        'Blades of Khorne',
        'Pick one melee weapon. -1 Rend wound rolls of 6 inflict double damage.',
        'combat'
      ],
      [
        'Blood Drinker',
        'Blood Drinker',
        'Artifact',
        'Blades of Khorne',
        'Pick one melee weapon. At the end of any combat phase in which the bearer inflicts any unsaved wounds/mortal wounds with this weapon heal D3 wounds.',
        'combat'
      ],
      [
        'Deamon Bound',
        'Chaos Lord on Manticore',
        'Unit ability',
        'Blades of Khorne',
        'On a 6 to hit crit for 1 mortal wound.',
        'combat'
      ],
      [
        'Deamon Commander',
        'Charnel Host',
        'Battalion ability',
        'Blades of Khorne',
        'Reroll wound rolls of 1 for melee weapons in this battalion wholly within 16 inches of Bloodthirster from same battalion.',
        'combat'
      ],
      [
        'Devour the Craven',
        'Reapers of Vengeance',
        'Subfaction ability',
        'Blades of Khorne',
        'If enemy fails battleshock within 3 inches of Reapers of Vengeance Deamon units add d3 to models that flee.',
        'battleshock'
      ]
    ];

    try {
      final _firestore = FirebaseFirestore.instance;
      print(listOfAllRules.length);
      for (var i = 0; i < listOfAllRules.length; i++) {
        var ruleName = listOfAllRules[i][0];
        var ruleSource = listOfAllRules[i][1];
        var ruleSourceType = listOfAllRules[i][2];
        var ruleFaction = listOfAllRules[i][3];
        var ruleText = listOfAllRules[i][4];
        var rulePhase = listOfAllRules[i][5];
        await _firestore.collection('rules').add({
          'ruleFaction': ruleFaction,
          'ruleName': ruleName,
          'rulePhase': rulePhase,
          'ruleSource': ruleSource,
          'ruleSourceType': ruleSourceType,
          'ruleText': ruleText,
        });
        print("record added: ");
        print(listOfAllRules[i]);
      }
      return 'Saved!';
    } catch (e) {
      print(e);
    }
  }
}
