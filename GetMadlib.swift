//
//  GetMadlib.swift
//  Bad Lib
//
//  Created by Peter Frost on 22/11/2015.
//  Copyright © 2015 Peter Frost. All rights reserved.
//

import Foundation

//The UInt32 is the offensiveness scale, 0 being fairly PG, 3 being fucking profanic
//String is the... String. Obviously.
//Many of these words and the offensiveness rating came from:
//https://www.ipsos.com/sites/default/files/publication/1970-01/connect-ofcom-offensive-language-2016.pdf

//Need to add selecting from range of offensiveness

let Adjective: [UInt32: [String]] = [0: ["spongy","temporary","itchy", "young", "old",
                                         "massive", "enourmous", "tiny", "adorable", "aching",
                                         "ample", "awkward", "awful", "amusing",
                                         "beautiful", "boring", "bouncy", "brisk, tasteful"],
                                     1: ["moist", "aggressive", "baggy", "bruised", "bloody"],
                                     2: ["girthy", "pissed", "gay", "queer"],
                                     3: ["anal", "faggot"]]

let Verb: [UInt32: [String]] = [0: ["explode", "cook", "annoy", "blind", "boil", "burn",
                                    "cough", "destroy", "fail", "flap", "ignore", "juggle",
                                    "offend", "preach", "irradiate", "serve", "shave", "rob",
                                    "sniff", "tip", "touch", "caress", "wreck", "fly", "seal"],
                                1: ["chunder", "sext", "vomit", "bang", "bomb", "choke", "nail", "punish",
                                    "satisfy", "smash", "stroke", "tap", "tug", "whip", "undress",
                                    "bonk"],
                                2: ["sext", "suck", "shag"],
                                3: ["tit wank", "cum", "ejaculate", "fuck"]]

let Noun: [UInt32: [String]] = [0: ["shambles", "jungle", "pit", "towelette", "toes",
                                    "rabbit", "puppies", "drill", "peg leg", "birdfeeder", "dirt",
                                    "coffee", "lunchbox", "steering wheel", "salami", "pancake",
                                    "lemon", "empire"],
                                1: ["dump", "hole", "tip", "bush", "hedge", "slum", "bomb site", "white people", "tomb", "self-sacrifice", "sausage", "ass", "cow", "ginger", "git", "minger", "bint", "pansy", "nut"],
                                2: ["rod", "sideboob", "wiener","pervert", "pile of decomposition",
                                    "dick", "shit killer", "lifetime of sadness", "roofies", "bitch",
                                    "bullshit", "munter", "tits", "bastard", "beaver", "beef curtains",
                                    "bellend", "dickhead", "flaps", "knob", "prick", "twat", "slapper",
                                    "tart", "cocksucker", "ho", "prickteaser", "poof", "vegetable"],
                                3: ["clunge", "dildo", "sex", "pussy", "fanny", "gash", "AIDS",
                                    "erection that lasts longer than 4 hours", "penis", "vagina",
                                    "ribbed condom", "arsehole","sperm", "foreskin", "minge", "cunt",
                                    "motherfucker", "bukkake", "jizz", "slag", "slut", "whore",
                                    "retard", "spastic"]]

let Adverb: [UInt32: [String]] = [0: ["accidentally", "tenderly", "powerfully", "intensely", "slowly"],
                                  1: ["creepily"],
                                  2: [""],
                                  3: ["sexily"]]

let Exclamation: [UInt32: [String]] = [0: ["great scott", "goodness gracious", "good grief", "damn", "oh no"],
                                       1: ["oh balls", "oh lord", "bugger", "jesus christ"],
                                       2: ["crap", "bollocks", "feck", "shit", "son of a bitch", "oh cock"],
                                       3: ["shit on my face", "fucking hell", "ah me fanny", "cunt balls",
                                           "fuck a monkey shit", "fuck a duck"]]

//It doesn't really make sense to have an offensiveness scale for these words

let Pronoun: [UInt32: String] = [0: "he", 1: "she"]

let Preposition: [UInt32: String] = [0: "after", 1: "in"]

let Conjunction: [UInt32: String] = [0: "and", 1: "because"]

let Determiner: [UInt32: String] = [0: "a", 1: "the"]

var chosenOffensiveness: UInt32 = 0
var offensivenessExc: Bool = false

func makeMadLib() -> String {
    var MadLibDict = ""
    let random = arc4random_uniform(2)
    offensivenessExc = UserDefaults.standard.object(forKey: "wordOffensivenessExclusiv") as? Bool ?? false
    chosenOffensiveness = UserDefaults.standard.object(forKey: "wordOffensiveness") as? UInt32 ?? 0
    
    if (random == 0) {
        MadLibDict = ("Patient: Thank you so much for seeing me doctor on such short notice. " +
            "Dentist: What is the problem \(Choose("Adjective", tense: 0)) \(Choose("Noun", tense: 0))? " +
            "Patient: I have a pain in my upper \(Choose("Noun", tense: 0)) which is giving me a severe \(Choose("Noun", tense: 0)) ache. " +
            "Dentist: Let me take a look, open your \(Choose("Adjective", tense: 0)) \(Choose("Noun", tense: 0)) wide, good, now I'm going to tap your \(Choose("Noun", tense: 0)) with my \(Choose("Noun", tense: 0)). " +
            "Patient: Shouldn't you give me a \(Choose("Noun", tense: 0))? " +
            "Dentist: It's not necessary yet.. \(Choose("Exclamation", tense: 0))! I think I see a \(Choose("Noun", tense: 0)) in your upper \(Choose("Noun", tense: 0)). " +
            "Patient: Are you going to pull my \(Choose("Noun", tense: 0)) out? " +
            "Dentist: No I'm going to \(Choose("Verb", tense: 0)) your \(Choose("Noun", tense: 0)) in a \(Choose("Adjective", tense: 0)) \(Choose("Noun", tense: 0)). " +
            "Patient: When do I come back for my \(Choose("Adjective", tense: 0)) filling? " +
            "Dentist: A day after I cash my \(Choose("Adjective", tense: 0)) \(Choose("Noun", tense: 0))!")
    } else if (random == 1) {
        MadLibDict = ("Excuse me sir you \(Choose("Verb", tense: 1)) your wallet! " +
            "\(Choose("Exclamation", tense: 0)), you saved my \(Choose("Noun", tense: 0)), I had my \(Choose("Noun", tense: 0)) in there. " +
            "\(Choose("Exclamation", tense: 0)) don't mention it, you seem like an \(Choose("Adjective", tense: 0)) gentleman. " +
            "Thank you I could give you a \(Choose("Adjective", tense: 0)) \(Choose("Noun", tense: 0)) if you want? " +
            "I'll take a \(Choose("Adjective", tense: 0)) \(Choose("Noun", tense: 0)) \(Choose("Preposition", tense: 0)) my \(Choose("Noun", tense: 0)) if you're offering? " +
            "Of course, if you want I'll \(Choose("Verb", tense: 0)) on your \(Choose("Noun", tense: 0)) after I've \(Choose("Verb", tense: 1)) on my \(Choose("Noun", tense: 0)) in the \(Choose("Noun", tense: 0)). " +
            "\(Choose("Exclamation", tense: 0)) I just \(Choose("Adverb", tense: 0)) \(Choose("Verb", tense: 1)) a \(Choose("Noun", tense: 0)) in your wallet. ")
    }
    return MadLibDict
}

func Choose(_ wordType: String, tense: Int) -> String {
    var word = String()
    var newword = String()
    var offensiveness: UInt32 = chosenOffensiveness
    if (offensivenessExc == false) {
        offensiveness = arc4random_uniform(chosenOffensiveness + 1)
    }
    
    //0 is the selected / maximum offensiveness to pick from
    switch wordType {
    case "Adjective":
        word = Adjective[offensiveness]![Int(arc4random_uniform(UInt32((Adjective[offensiveness]?.count)!)))]
    case "Verb":
        word = Verb[offensiveness]![Int(arc4random_uniform(UInt32((Verb[offensiveness]?.count)!)))]
    case "Noun":
        word = Noun[offensiveness]![Int(arc4random_uniform(UInt32((Noun[offensiveness]?.count)!)))]
    case "Adverb":
        word = Adverb[offensiveness]![Int(arc4random_uniform(UInt32((Adverb[offensiveness]?.count)!)))]
    case "Exclamation":
        word = Exclamation[offensiveness]![Int(arc4random_uniform(UInt32((Exclamation[offensiveness]?.count)!)))]
    case "Pronoun":
        word = (Pronoun[arc4random_uniform(2)])!
    case "Preposition":
        word = (Preposition[arc4random_uniform(2)])!
    case "Conjunction":
        word = (Conjunction[arc4random_uniform(2)])!
    case "Determiner":
        word = (Determiner[arc4random_uniform(2)])!
    default:
        print("ERROR: Couldn't find a case for 'wordType', probably a typo somewhere dipshit")
    }
    

    
    //0 = present
    //1 = past
    
    if tense == 1 {
        if word[word.index(before: word.endIndex)] == "e" {
            word += "d"
        } else if word[word.index(before: word.endIndex)] == "b" {
            word += "bed"
        } else if word[word.index(before: word.endIndex)] == "p" {
            word += "ped"
        } else if word[word.index(before: word.endIndex)] == "g" {
            word += "ged"
        } else if word[word.index(before: word.endIndex)] == "y" {
            newword = word
            newword.remove(at: word.index(before: word.endIndex))
            if newword[newword.index(before: newword.endIndex)] == "f" {
                newword += "ied"
                word = newword
            } else {
                word += "yed"
            }
        } else {
            word += "ed"
        }
    }
    
    return word
}
