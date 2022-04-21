-----------------------------------
-- Add some npcs for testers in starter cities.
-----------------------------------
require("modules/module_utils")
-----------------------------------
local m = Module:new("wings_alpha_test_npcs")
m:setEnabled(true)

m:addOverride("xi.zones.Bastok_Mines.Zone.onInitialize", function(zone)

    -- Call the zone's original function for onInitialize
    super(zone)

    -- Insert NPC into zone
    local Lili = zone:insertDynamicEntity({

        -- NPC or MOB
        objtype = xi.objType.NPC,

        -- The name visible to players
        -- NOTE: Even if you plan on making the name invisible, we're using it internally for lookups
        --     : So populate it with something unique-ish even if you aren't going to use it.
        --     : You can then hide the name with entity:hideName(true)
        -- NOTE: This name CAN include spaces and underscores.
        name = "Lilisette",

        -- You can use regular model ids (See documentation/model_ids.txt, or play around with !costume)
        look = 3049,

        -- You can also use the raw packet look information (as a string), as seen in npc_list and mob_pools
        -- look = "0x0100020500101120003000400050006000700000",

        -- Set the position using in-game x, y and z
        x = 93.446,
        y = 0.623,
        z = -68.917,

        -- Rotation is scaled 0-255, with 0 being East
        rotation = 128,

        -- Overriding widescan is only available to NPCs.
        widescan = 1,

        -- onTrade and onTrigger can be hooked up to your dynamic entity,
        -- just like with regular entities. You can also omit these.
        onTrade = function(player, npc, trade)
            -- NOTE: We have to use getPacketName, because the regular name is modified and being used
            --     : for internal lookups
            player:PrintToPlayer("No, thanks!", 0, npc:getPacketName())
        end,

        -- The entity will not be "triggerable" unless you populate onTrigger
        onTrigger = function(player, npc)
            -- NOTE: We have to use getPacketName, because the regular name is modified and being used
            --     : for internal lookups
            if player:getCharVar(string.format("[Alpha]Talked_to_%s", npc:getName())) ~= 1 then
                player:PrintToPlayer("Welcome to the WingsXI 3.0 Alpha Stress Test!", 0,npc:getPacketName())
                player:PrintToPlayer("To help you get on your way with testing I will be able to set your level to 99, SAM/WAR, and equipement.", 0,npc:getPacketName())
                player:PrintToPlayer("Just talk to me again to start the process.", 0, npc:getPacketName())
                player:setCharVar(string.format("[ALPHA]Talked_to_%s", npc:getName()), 1)
            elseif player:getCharVar(string.format("[Alpha]Talked_to_%s", npc:getName())) == 1 then
                local equipmentList =
                {
                    21956, -- Weapon Main
                    22212, -- Sub
                    21371, -- Ammo
                    25569, -- Head
                    25485, -- Neck
                    27544, -- Ear1
                    27545, -- Ear2
                    25733, -- Body
                    23520, -- Hands
                    26185, -- Ring1
                    26182, -- Ring2
                    26257, -- Back
                    28428, -- Waist
                    25856, -- Legs
                    27472, -- Feet
                }

                local ValidSpells =
                {
                    -- Spells
                    1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37,
                    38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71,
                    72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104,
                    105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130,
                    131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156,
                    157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182,
                    183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207, 208,
                    209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234,
                    235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255, 256, 257, 258, 259, 260,
                    261, 262, 263, 264, 265, 266, 267, 268, 269, 270, 271, 272, 273, 274, 275, 276, 277, 278, 279, 280, 281, 282, 283, 284, 285, 286,
                    287, 288, 289, 290, 291, 292, 293, 294, 295, 296, 297, 298, 299, 300, 301, 302, 303, 304, 305, 306, 307, 308, 309, 310, 311, 312,
                    313, 314, 315, 316, 317, 318, 319, 320, 321, 322, 323, 324, 325, 326, 327, 328, 329, 330, 331, 332, 333, 334, 335, 336, 337, 338,
                    339, 340, 341, 342, 343, 344, 345, 346, 347, 348, 349, 350, 351, 352, 353, 354, 355, 356, 357, 358, 359, 360, 361, 362, 363, 364,
                    365, 366, 367, 368, 369, 370, 371, 372, 373, 374, 375, 376, 377, 378, 379, 380, 381, 382, 383, 384, 385, 386, 387, 388, 389, 390,
                    391, 392, 393, 394, 395, 396, 397, 398, 399, 400, 401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 412, 413, 414, 415, 416,
                    417, 418, 419, 420, 421, 422, 423, 424, 425, 426, 427, 428, 429, 430, 431, 432, 433, 434, 435, 436, 437, 438, 439, 440, 441, 442,
                    443, 444, 445, 446, 447, 448, 449, 450, 451, 452, 453, 454, 455, 456, 457, 458, 459, 460, 461, 462, 463, 464, 465, 466, 467, 468,
                    469, 470, 471, 472, 473, 474, 475, 476, 477, 478, 479, 480, 481, 482, 483, 484, 485, 486, 487, 488, 489, 490, 491, 492, 493, 494,
                    495, 496, 497, 498, 499, 500, 501, 502, 503, 504, 505, 506, 507, 508, 509, 510, 511, 512, 513, 515, 517, 519, 521, 522, 524, 527,
                    529, 530, 531, 532, 533, 534, 535, 536, 537, 538, 539, 540, 541, 542, 543, 544, 545, 547, 548, 549, 551, 554, 555, 557, 560, 561,
                    563, 564, 565, 567, 569, 570, 572, 573, 574, 575, 576, 577, 578, 579, 581, 582, 584, 585, 587, 588, 589, 591, 592, 593, 594, 595,
                    596, 597, 598, 599, 603, 604, 605, 606, 608, 610, 611, 612, 613, 614, 615, 616, 617, 618, 620, 621, 622, 623, 626, 628, 629, 631,
                    632, 633, 634, 636, 637, 638, 640, 641, 642, 643, 644, 645, 646, 647, 648, 649, 650, 651, 652, 653, 654, 655, 656, 657, 658, 659,
                    660, 661, 662, 663, 664, 665, 666, 667, 668, 669, 670, 671, 672, 673, 674, 675, 676, 677, 678, 679, 680, 681, 682, 683, 684, 685,
                    686, 687, 688, 689, 690, 691, 692, 693, 694, 695, 696, 697, 698, 699, 700, 701, 702, 703, 704, 705, 706, 707, 708, 709, 710, 711,
                    712, 713, 714, 715, 716, 717, 718, 719, 720, 721, 722, 723, 724, 725, 726, 727, 728, 736, 737, 738, 739, 740, 741, 742, 743, 744,
                    745, 746, 747, 748, 749, 768, 769, 770, 771, 772, 773, 774, 775, 776, 777, 778, 779, 780, 781, 782, 783, 784, 785, 786, 787, 788,
                    789, 790, 791, 792, 793, 794, 795, 796, 797, 798, 799, 800, 801, 802, 803, 804, 805, 806, 807, 808, 809, 810, 811, 812, 813, 814,
                    815, 816, 817, 818, 819, 820, 821, 822, 823, 824, 825, 826, 827, 828, 829, 830, 831, 832, 833, 834, 835, 836, 837, 838, 839, 840,
                    841, 842, 843, 844, 845, 846, 847, 848, 849, 850, 851, 852, 853, 854, 855, 856, 857, 858, 859, 860, 861, 862, 863, 864, 865, 866,
                    867, 868, 869, 870, 871, 872, 873, 874, 875, 876, 877, 878, 879, 880, 881, 882, 883, 884, 885, 886, 887, 888, 889, 890, 891, 892,
                    893, 894, 895,
                }
                
                player:changeContainerSize(xi.inv.INVENTORY, 80)
                player:changeJob(xi.job.SAM)
                player:changesJob(xi.job.WAR)
                player:setLevel(99)
                player:setsLevel(player:getMainLvl()/2)
                player:capAllSkills()
                player:unkillable(true)

                for i = 1, #ValidSpells do
                    if i == #ValidSpells then
                        silent = false
                    end
            
                    player:addSpell(ValidSpells[i], silent, save, sendUpdate)
                end

                for i = 1, 49 do
                    player:addLearnedWeaponskill(i)
                end

                for _, item in pairs(equipmentList) do
                    player:addItem(item, 1)
                end
            end
        end,
    })

    local Cait = zone:insertDynamicEntity({

        -- NPC or MOB
        objtype = xi.objType.NPC,

        -- The name visible to players
        -- NOTE: Even if you plan on making the name invisible, we're using it internally for lookups
        --     : So populate it with something unique-ish even if you aren't going to use it.
        --     : You can then hide the name with entity:hideName(true)
        -- NOTE: This name CAN include spaces and underscores.
        name = "Cait Sith",

        -- You can use regular model ids (See documentation/model_ids.txt, or play around with !costume)
        look = 2197,

        -- You can also use the raw packet look information (as a string), as seen in npc_list and mob_pools
        -- look = "0x0100020500101120003000400050006000700000",

        -- Set the position using in-game x, y and z
        x = 93.228,
        y = 0.623,
        z = -72.038,

        -- Rotation is scaled 0-255, with 0 being East
        rotation = 128,

        -- Overriding widescan is only available to NPCs.
        widescan = 1,

        -- onTrade and onTrigger can be hooked up to your dynamic entity,
        -- just like with regular entities. You can also omit these.
        onTrade = function(player, npc, trade)
            -- NOTE: We have to use getPacketName, because the regular name is modified and being used
            --     : for internal lookups
            player:PrintToPlayer("No, thanks!", 0, npc:getPacketName())
        end,

        -- The entity will not be "triggerable" unless you populate onTrigger
        onTrigger = function(player, npc)
            -- NOTE: We have to use getPacketName, because the regular name is modified and being used
            --     : for internal lookups
            if player:getCharVar(string.format("[Alpha]Talked_to_%s", npc:getName())) ~= 1 then
                player:PrintToPlayer("Welcome to the WingsXI 3.0 Alpha Stress Test!", 0,npc:getPacketName())
                player:PrintToPlayer("To help you get on your way with testing I will be able to set your level to 99, SCH/RDM, and equipement.", 0,npc:getPacketName())
                player:PrintToPlayer("Just talk to me again to start the process.", 0, npc:getPacketName())
                player:setCharVar(string.format("[ALPHA]Talked_to_%s", npc:getName()), 1)
            elseif player:getCharVar(string.format("[Alpha]Talked_to_%s", npc:getName())) == 1 then
                local equipmentList =
                {
                    21150, -- Weapon Main
                    22213, -- Sub
                    22271, -- Ammo
                    23417, -- Head
                    25533, -- Neck
                    26085, -- Ear1
                    27526, -- Ear2
                    25689, -- Body
                    27120, -- Hands
                    26194, -- Ring1
                    27563, -- Ring2
                    26265, -- Back
                    28419, -- Waist
                    27305, -- Legs
                    27476, -- Feet
                }

                local ValidSpells =
                {
                    -- Spells
                    1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37,
                    38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71,
                    72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104,
                    105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130,
                    131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156,
                    157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182,
                    183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207, 208,
                    209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234,
                    235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255, 256, 257, 258, 259, 260,
                    261, 262, 263, 264, 265, 266, 267, 268, 269, 270, 271, 272, 273, 274, 275, 276, 277, 278, 279, 280, 281, 282, 283, 284, 285, 286,
                    287, 288, 289, 290, 291, 292, 293, 294, 295, 296, 297, 298, 299, 300, 301, 302, 303, 304, 305, 306, 307, 308, 309, 310, 311, 312,
                    313, 314, 315, 316, 317, 318, 319, 320, 321, 322, 323, 324, 325, 326, 327, 328, 329, 330, 331, 332, 333, 334, 335, 336, 337, 338,
                    339, 340, 341, 342, 343, 344, 345, 346, 347, 348, 349, 350, 351, 352, 353, 354, 355, 356, 357, 358, 359, 360, 361, 362, 363, 364,
                    365, 366, 367, 368, 369, 370, 371, 372, 373, 374, 375, 376, 377, 378, 379, 380, 381, 382, 383, 384, 385, 386, 387, 388, 389, 390,
                    391, 392, 393, 394, 395, 396, 397, 398, 399, 400, 401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 412, 413, 414, 415, 416,
                    417, 418, 419, 420, 421, 422, 423, 424, 425, 426, 427, 428, 429, 430, 431, 432, 433, 434, 435, 436, 437, 438, 439, 440, 441, 442,
                    443, 444, 445, 446, 447, 448, 449, 450, 451, 452, 453, 454, 455, 456, 457, 458, 459, 460, 461, 462, 463, 464, 465, 466, 467, 468,
                    469, 470, 471, 472, 473, 474, 475, 476, 477, 478, 479, 480, 481, 482, 483, 484, 485, 486, 487, 488, 489, 490, 491, 492, 493, 494,
                    495, 496, 497, 498, 499, 500, 501, 502, 503, 504, 505, 506, 507, 508, 509, 510, 511, 512, 513, 515, 517, 519, 521, 522, 524, 527,
                    529, 530, 531, 532, 533, 534, 535, 536, 537, 538, 539, 540, 541, 542, 543, 544, 545, 547, 548, 549, 551, 554, 555, 557, 560, 561,
                    563, 564, 565, 567, 569, 570, 572, 573, 574, 575, 576, 577, 578, 579, 581, 582, 584, 585, 587, 588, 589, 591, 592, 593, 594, 595,
                    596, 597, 598, 599, 603, 604, 605, 606, 608, 610, 611, 612, 613, 614, 615, 616, 617, 618, 620, 621, 622, 623, 626, 628, 629, 631,
                    632, 633, 634, 636, 637, 638, 640, 641, 642, 643, 644, 645, 646, 647, 648, 649, 650, 651, 652, 653, 654, 655, 656, 657, 658, 659,
                    660, 661, 662, 663, 664, 665, 666, 667, 668, 669, 670, 671, 672, 673, 674, 675, 676, 677, 678, 679, 680, 681, 682, 683, 684, 685,
                    686, 687, 688, 689, 690, 691, 692, 693, 694, 695, 696, 697, 698, 699, 700, 701, 702, 703, 704, 705, 706, 707, 708, 709, 710, 711,
                    712, 713, 714, 715, 716, 717, 718, 719, 720, 721, 722, 723, 724, 725, 726, 727, 728, 736, 737, 738, 739, 740, 741, 742, 743, 744,
                    745, 746, 747, 748, 749, 768, 769, 770, 771, 772, 773, 774, 775, 776, 777, 778, 779, 780, 781, 782, 783, 784, 785, 786, 787, 788,
                    789, 790, 791, 792, 793, 794, 795, 796, 797, 798, 799, 800, 801, 802, 803, 804, 805, 806, 807, 808, 809, 810, 811, 812, 813, 814,
                    815, 816, 817, 818, 819, 820, 821, 822, 823, 824, 825, 826, 827, 828, 829, 830, 831, 832, 833, 834, 835, 836, 837, 838, 839, 840,
                    841, 842, 843, 844, 845, 846, 847, 848, 849, 850, 851, 852, 853, 854, 855, 856, 857, 858, 859, 860, 861, 862, 863, 864, 865, 866,
                    867, 868, 869, 870, 871, 872, 873, 874, 875, 876, 877, 878, 879, 880, 881, 882, 883, 884, 885, 886, 887, 888, 889, 890, 891, 892,
                    893, 894, 895,
                }
                
                player:changeContainerSize(xi.inv.INVENTORY, 80)
                player:changeJob(xi.job.SCH)
                player:changesJob(xi.job.RDM)
                player:setLevel(99)
                player:setsLevel(player:getMainLvl()/2)
                player:capAllSkills()
                player:unkillable(true)

                for i = 1, #ValidSpells do
                    if i == #ValidSpells then
                        silent = false
                    end
            
                    player:addSpell(ValidSpells[i], silent, save, sendUpdate)
                end

                for i = 1, 49 do
                    player:addLearnedWeaponskill(i)
                end

                for _, item in pairs(equipmentList) do
                    player:addItem(item, 1)
                end
            end
        end,
    })

    local Lilit = zone:insertDynamicEntity({

        -- NPC or MOB
        objtype = xi.objType.NPC,

        -- The name visible to players
        -- NOTE: Even if you plan on making the name invisible, we're using it internally for lookups
        --     : So populate it with something unique-ish even if you aren't going to use it.
        --     : You can then hide the name with entity:hideName(true)
        -- NOTE: This name CAN include spaces and underscores.
        name = "Lilith",

        -- You can use regular model ids (See documentation/model_ids.txt, or play around with !costume)
        look = 2289,

        -- You can also use the raw packet look information (as a string), as seen in npc_list and mob_pools
        -- look = "0x0100020500101120003000400050006000700000",

        -- Set the position using in-game x, y and z
        x = 93.253,
        y = 0.623,
        z = -75.164,

        -- Rotation is scaled 0-255, with 0 being East
        rotation = 128,

        -- Overriding widescan is only available to NPCs.
        widescan = 1,

        -- onTrade and onTrigger can be hooked up to your dynamic entity,
        -- just like with regular entities. You can also omit these.
        onTrade = function(player, npc, trade)
            -- NOTE: We have to use getPacketName, because the regular name is modified and being used
            --     : for internal lookups
            player:PrintToPlayer("No, thanks!", 0, npc:getPacketName())
        end,

        -- The entity will not be "triggerable" unless you populate onTrigger
        onTrigger = function(player, npc)
            -- NOTE: We have to use getPacketName, because the regular name is modified and being used
            --     : for internal lookups
            player:PrintToPlayer("Welcome to the WingsXI 3.0 Alpha Stress Test!", 0,npc:getPacketName())
            player:PrintToPlayer("My name is Lilith and my job is to help testers learn about what we are trying to do.", 0,npc:getPacketName())
            player:PrintToPlayer("Testers are free to do whatever they want, but please follow directions given in server messages for objectives.", 0, npc:getPacketName())
            player:PrintToPlayer("Here are some useful commands to help you in testing:", 0, npc:getPacketName())
            player:PrintToPlayer("!zone (auto-translate zone name) will allow you to go between different zones easily.", 0, npc:getPacketName())
            player:PrintToPlayer("!changejob (Job Abv) (Level) changes your main job and level.", 0, npc:getPacketName())
            player:PrintToPlayer("!changesjob (Job Abv) (Level) will change your subjob. Please remember SJ level is MJ/2.", 0, npc:getPacketName())
            player:PrintToPlayer("!additem (itemID) {qty} allows you to add an item to your inventory.", 0, npc:getPacketName())
            player:PrintToPlayer("!setgil (amount) will set your gil to that amount.", 0, npc:getPacketName())
            player:PrintToPlayer("!release will allow you to get out of cutscenes you do not want to watch.", 0, npc:getPacketName())
            player:PrintToPlayer("!speed (1-200) will increase or decrease your speed. Default speed is 40, Flee is 100.", 0, npc:getPacketName())
            player:PrintToPlayer("!togglegm will turn on your GM flag.", 0, npc:getPacketName())
            player:PrintToPlayer("If you change jobs, use !capallskills.", 0, npc:getPacketName())
            player:PrintToPlayer("You can also use !goto (player) to go to your friends.", 0, npc:getPacketName())
        end,
    })

    -- Use the mob object however you like
    -- horro:getID() etc.
    -- We're not doing anything with it, so ignore this object
    utils.unused(Lili)
    utils.unused(Cait)
    utils.unused(Lilit)

    -- You could also just not capture the object
    -- zone:insertDynamicEntity({ ...
end)

m:addOverride("xi.zones.Port_Windurst.Zone.onInitialize", function(zone)

    -- Call the zone's original function for onInitialize
    super(zone)

    -- Insert NPC into zone
    local Lili = zone:insertDynamicEntity({

        -- NPC or MOB
        objtype = xi.objType.NPC,

        -- The name visible to players
        -- NOTE: Even if you plan on making the name invisible, we're using it internally for lookups
        --     : So populate it with something unique-ish even if you aren't going to use it.
        --     : You can then hide the name with entity:hideName(true)
        -- NOTE: This name CAN include spaces and underscores.
        name = "Lilisette",

        -- You can use regular model ids (See documentation/model_ids.txt, or play around with !costume)
        look = 3049,

        -- You can also use the raw packet look information (as a string), as seen in npc_list and mob_pools
        -- look = "0x0100020500101120003000400050006000700000",

        -- Set the position using in-game x, y and z
        x = 182.409,
        y = -12.000,
        z = 229.149,

        -- Rotation is scaled 0-255, with 0 being East
        rotation = 50,

        -- Overriding widescan is only available to NPCs.
        widescan = 1,

        -- onTrade and onTrigger can be hooked up to your dynamic entity,
        -- just like with regular entities. You can also omit these.
        onTrade = function(player, npc, trade)
            -- NOTE: We have to use getPacketName, because the regular name is modified and being used
            --     : for internal lookups
            player:PrintToPlayer("No, thanks!", 0, npc:getPacketName())
        end,

        -- The entity will not be "triggerable" unless you populate onTrigger
        onTrigger = function(player, npc)
            -- NOTE: We have to use getPacketName, because the regular name is modified and being used
            --     : for internal lookups
            if player:getCharVar(string.format("[Alpha]Talked_to_%s", npc:getName())) ~= 1 then
                player:PrintToPlayer("Welcome to the WingsXI 3.0 Alpha Stress Test!", 0,npc:getPacketName())
                player:PrintToPlayer("To help you get on your way with testing I will be able to set your level to 99, SAM/WAR, and equipement.", 0,npc:getPacketName())
                player:PrintToPlayer("Just talk to me again to start the process.", 0, npc:getPacketName())
                player:setCharVar(string.format("[ALPHA]Talked_to_%s", npc:getName()), 1)
            elseif player:getCharVar(string.format("[Alpha]Talked_to_%s", npc:getName())) == 1 then
                local equipmentList =
                {
                    21956, -- Weapon Main
                    22212, -- Sub
                    21371, -- Ammo
                    25569, -- Head
                    25485, -- Neck
                    27544, -- Ear1
                    27545, -- Ear2
                    25733, -- Body
                    23520, -- Hands
                    26185, -- Ring1
                    26182, -- Ring2
                    26257, -- Back
                    28428, -- Waist
                    25856, -- Legs
                    27472, -- Feet
                }

                local ValidSpells =
                {
                    -- Spells
                    1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37,
                    38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71,
                    72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104,
                    105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130,
                    131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156,
                    157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182,
                    183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207, 208,
                    209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234,
                    235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255, 256, 257, 258, 259, 260,
                    261, 262, 263, 264, 265, 266, 267, 268, 269, 270, 271, 272, 273, 274, 275, 276, 277, 278, 279, 280, 281, 282, 283, 284, 285, 286,
                    287, 288, 289, 290, 291, 292, 293, 294, 295, 296, 297, 298, 299, 300, 301, 302, 303, 304, 305, 306, 307, 308, 309, 310, 311, 312,
                    313, 314, 315, 316, 317, 318, 319, 320, 321, 322, 323, 324, 325, 326, 327, 328, 329, 330, 331, 332, 333, 334, 335, 336, 337, 338,
                    339, 340, 341, 342, 343, 344, 345, 346, 347, 348, 349, 350, 351, 352, 353, 354, 355, 356, 357, 358, 359, 360, 361, 362, 363, 364,
                    365, 366, 367, 368, 369, 370, 371, 372, 373, 374, 375, 376, 377, 378, 379, 380, 381, 382, 383, 384, 385, 386, 387, 388, 389, 390,
                    391, 392, 393, 394, 395, 396, 397, 398, 399, 400, 401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 412, 413, 414, 415, 416,
                    417, 418, 419, 420, 421, 422, 423, 424, 425, 426, 427, 428, 429, 430, 431, 432, 433, 434, 435, 436, 437, 438, 439, 440, 441, 442,
                    443, 444, 445, 446, 447, 448, 449, 450, 451, 452, 453, 454, 455, 456, 457, 458, 459, 460, 461, 462, 463, 464, 465, 466, 467, 468,
                    469, 470, 471, 472, 473, 474, 475, 476, 477, 478, 479, 480, 481, 482, 483, 484, 485, 486, 487, 488, 489, 490, 491, 492, 493, 494,
                    495, 496, 497, 498, 499, 500, 501, 502, 503, 504, 505, 506, 507, 508, 509, 510, 511, 512, 513, 515, 517, 519, 521, 522, 524, 527,
                    529, 530, 531, 532, 533, 534, 535, 536, 537, 538, 539, 540, 541, 542, 543, 544, 545, 547, 548, 549, 551, 554, 555, 557, 560, 561,
                    563, 564, 565, 567, 569, 570, 572, 573, 574, 575, 576, 577, 578, 579, 581, 582, 584, 585, 587, 588, 589, 591, 592, 593, 594, 595,
                    596, 597, 598, 599, 603, 604, 605, 606, 608, 610, 611, 612, 613, 614, 615, 616, 617, 618, 620, 621, 622, 623, 626, 628, 629, 631,
                    632, 633, 634, 636, 637, 638, 640, 641, 642, 643, 644, 645, 646, 647, 648, 649, 650, 651, 652, 653, 654, 655, 656, 657, 658, 659,
                    660, 661, 662, 663, 664, 665, 666, 667, 668, 669, 670, 671, 672, 673, 674, 675, 676, 677, 678, 679, 680, 681, 682, 683, 684, 685,
                    686, 687, 688, 689, 690, 691, 692, 693, 694, 695, 696, 697, 698, 699, 700, 701, 702, 703, 704, 705, 706, 707, 708, 709, 710, 711,
                    712, 713, 714, 715, 716, 717, 718, 719, 720, 721, 722, 723, 724, 725, 726, 727, 728, 736, 737, 738, 739, 740, 741, 742, 743, 744,
                    745, 746, 747, 748, 749, 768, 769, 770, 771, 772, 773, 774, 775, 776, 777, 778, 779, 780, 781, 782, 783, 784, 785, 786, 787, 788,
                    789, 790, 791, 792, 793, 794, 795, 796, 797, 798, 799, 800, 801, 802, 803, 804, 805, 806, 807, 808, 809, 810, 811, 812, 813, 814,
                    815, 816, 817, 818, 819, 820, 821, 822, 823, 824, 825, 826, 827, 828, 829, 830, 831, 832, 833, 834, 835, 836, 837, 838, 839, 840,
                    841, 842, 843, 844, 845, 846, 847, 848, 849, 850, 851, 852, 853, 854, 855, 856, 857, 858, 859, 860, 861, 862, 863, 864, 865, 866,
                    867, 868, 869, 870, 871, 872, 873, 874, 875, 876, 877, 878, 879, 880, 881, 882, 883, 884, 885, 886, 887, 888, 889, 890, 891, 892,
                    893, 894, 895,
                }
                
                player:changeContainerSize(xi.inv.INVENTORY, 80)
                player:changeJob(xi.job.SAM)
                player:changesJob(xi.job.WAR)
                player:setLevel(99)
                player:setsLevel(player:getMainLvl()/2)
                player:capAllSkills()
                player:unkillable(true)

                for i = 1, #ValidSpells do
                    if i == #ValidSpells then
                        silent = false
                    end
            
                    player:addSpell(ValidSpells[i], silent, save, sendUpdate)
                end

                for i = 1, 49 do
                    player:addLearnedWeaponskill(i)
                end

                for _, item in pairs(equipmentList) do
                    player:addItem(item, 1)
                end
            end
        end,
    })

    local Cait = zone:insertDynamicEntity({

        -- NPC or MOB
        objtype = xi.objType.NPC,

        -- The name visible to players
        -- NOTE: Even if you plan on making the name invisible, we're using it internally for lookups
        --     : So populate it with something unique-ish even if you aren't going to use it.
        --     : You can then hide the name with entity:hideName(true)
        -- NOTE: This name CAN include spaces and underscores.
        name = "Cait Sith",

        -- You can use regular model ids (See documentation/model_ids.txt, or play around with !costume)
        look = 2197,

        -- You can also use the raw packet look information (as a string), as seen in npc_list and mob_pools
        -- look = "0x0100020500101120003000400050006000700000",

        -- Set the position using in-game x, y and z
        x = 186.788,
        y = -12.000,
        z = 229.149,

        -- Rotation is scaled 0-255, with 0 being East
        rotation = 50,

        -- Overriding widescan is only available to NPCs.
        widescan = 1,

        -- onTrade and onTrigger can be hooked up to your dynamic entity,
        -- just like with regular entities. You can also omit these.
        onTrade = function(player, npc, trade)
            -- NOTE: We have to use getPacketName, because the regular name is modified and being used
            --     : for internal lookups
            player:PrintToPlayer("No, thanks!", 0, npc:getPacketName())
        end,

        -- The entity will not be "triggerable" unless you populate onTrigger
        onTrigger = function(player, npc)
            -- NOTE: We have to use getPacketName, because the regular name is modified and being used
            --     : for internal lookups
            if player:getCharVar(string.format("[Alpha]Talked_to_%s", npc:getName())) ~= 1 then
                player:PrintToPlayer("Welcome to the WingsXI 3.0 Alpha Stress Test!", 0,npc:getPacketName())
                player:PrintToPlayer("To help you get on your way with testing I will be able to set your level to 99, SCH/RDM, and equipement.", 0,npc:getPacketName())
                player:PrintToPlayer("Just talk to me again to start the process.", 0, npc:getPacketName())
                player:setCharVar(string.format("[ALPHA]Talked_to_%s", npc:getName()), 1)
            elseif player:getCharVar(string.format("[Alpha]Talked_to_%s", npc:getName())) == 1 then
                local equipmentList =
                {
                    21150, -- Weapon Main
                    22213, -- Sub
                    22271, -- Ammo
                    23417, -- Head
                    25533, -- Neck
                    26085, -- Ear1
                    27526, -- Ear2
                    25689, -- Body
                    27120, -- Hands
                    26194, -- Ring1
                    27563, -- Ring2
                    26265, -- Back
                    28419, -- Waist
                    27305, -- Legs
                    27476, -- Feet
                }

                local ValidSpells =
                {
                    -- Spells
                    1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37,
                    38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71,
                    72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104,
                    105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130,
                    131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156,
                    157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182,
                    183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207, 208,
                    209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234,
                    235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255, 256, 257, 258, 259, 260,
                    261, 262, 263, 264, 265, 266, 267, 268, 269, 270, 271, 272, 273, 274, 275, 276, 277, 278, 279, 280, 281, 282, 283, 284, 285, 286,
                    287, 288, 289, 290, 291, 292, 293, 294, 295, 296, 297, 298, 299, 300, 301, 302, 303, 304, 305, 306, 307, 308, 309, 310, 311, 312,
                    313, 314, 315, 316, 317, 318, 319, 320, 321, 322, 323, 324, 325, 326, 327, 328, 329, 330, 331, 332, 333, 334, 335, 336, 337, 338,
                    339, 340, 341, 342, 343, 344, 345, 346, 347, 348, 349, 350, 351, 352, 353, 354, 355, 356, 357, 358, 359, 360, 361, 362, 363, 364,
                    365, 366, 367, 368, 369, 370, 371, 372, 373, 374, 375, 376, 377, 378, 379, 380, 381, 382, 383, 384, 385, 386, 387, 388, 389, 390,
                    391, 392, 393, 394, 395, 396, 397, 398, 399, 400, 401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 412, 413, 414, 415, 416,
                    417, 418, 419, 420, 421, 422, 423, 424, 425, 426, 427, 428, 429, 430, 431, 432, 433, 434, 435, 436, 437, 438, 439, 440, 441, 442,
                    443, 444, 445, 446, 447, 448, 449, 450, 451, 452, 453, 454, 455, 456, 457, 458, 459, 460, 461, 462, 463, 464, 465, 466, 467, 468,
                    469, 470, 471, 472, 473, 474, 475, 476, 477, 478, 479, 480, 481, 482, 483, 484, 485, 486, 487, 488, 489, 490, 491, 492, 493, 494,
                    495, 496, 497, 498, 499, 500, 501, 502, 503, 504, 505, 506, 507, 508, 509, 510, 511, 512, 513, 515, 517, 519, 521, 522, 524, 527,
                    529, 530, 531, 532, 533, 534, 535, 536, 537, 538, 539, 540, 541, 542, 543, 544, 545, 547, 548, 549, 551, 554, 555, 557, 560, 561,
                    563, 564, 565, 567, 569, 570, 572, 573, 574, 575, 576, 577, 578, 579, 581, 582, 584, 585, 587, 588, 589, 591, 592, 593, 594, 595,
                    596, 597, 598, 599, 603, 604, 605, 606, 608, 610, 611, 612, 613, 614, 615, 616, 617, 618, 620, 621, 622, 623, 626, 628, 629, 631,
                    632, 633, 634, 636, 637, 638, 640, 641, 642, 643, 644, 645, 646, 647, 648, 649, 650, 651, 652, 653, 654, 655, 656, 657, 658, 659,
                    660, 661, 662, 663, 664, 665, 666, 667, 668, 669, 670, 671, 672, 673, 674, 675, 676, 677, 678, 679, 680, 681, 682, 683, 684, 685,
                    686, 687, 688, 689, 690, 691, 692, 693, 694, 695, 696, 697, 698, 699, 700, 701, 702, 703, 704, 705, 706, 707, 708, 709, 710, 711,
                    712, 713, 714, 715, 716, 717, 718, 719, 720, 721, 722, 723, 724, 725, 726, 727, 728, 736, 737, 738, 739, 740, 741, 742, 743, 744,
                    745, 746, 747, 748, 749, 768, 769, 770, 771, 772, 773, 774, 775, 776, 777, 778, 779, 780, 781, 782, 783, 784, 785, 786, 787, 788,
                    789, 790, 791, 792, 793, 794, 795, 796, 797, 798, 799, 800, 801, 802, 803, 804, 805, 806, 807, 808, 809, 810, 811, 812, 813, 814,
                    815, 816, 817, 818, 819, 820, 821, 822, 823, 824, 825, 826, 827, 828, 829, 830, 831, 832, 833, 834, 835, 836, 837, 838, 839, 840,
                    841, 842, 843, 844, 845, 846, 847, 848, 849, 850, 851, 852, 853, 854, 855, 856, 857, 858, 859, 860, 861, 862, 863, 864, 865, 866,
                    867, 868, 869, 870, 871, 872, 873, 874, 875, 876, 877, 878, 879, 880, 881, 882, 883, 884, 885, 886, 887, 888, 889, 890, 891, 892,
                    893, 894, 895,
                }
                
                player:changeContainerSize(xi.inv.INVENTORY, 80)
                player:changeJob(xi.job.SCH)
                player:changesJob(xi.job.RDM)
                player:setLevel(99)
                player:setsLevel(player:getMainLvl()/2)
                player:capAllSkills()
                player:unkillable(true)

                for i = 1, #ValidSpells do
                    if i == #ValidSpells then
                        silent = false
                    end
            
                    player:addSpell(ValidSpells[i], silent, save, sendUpdate)
                end

                for i = 1, 49 do
                    player:addLearnedWeaponskill(i)
                end

                for _, item in pairs(equipmentList) do
                    player:addItem(item, 1)
                end
            end
        end,
    })

    local Lilit = zone:insertDynamicEntity({

        -- NPC or MOB
        objtype = xi.objType.NPC,

        -- The name visible to players
        -- NOTE: Even if you plan on making the name invisible, we're using it internally for lookups
        --     : So populate it with something unique-ish even if you aren't going to use it.
        --     : You can then hide the name with entity:hideName(true)
        -- NOTE: This name CAN include spaces and underscores.
        name = "Lilith",

        -- You can use regular model ids (See documentation/model_ids.txt, or play around with !costume)
        look = 2289,

        -- You can also use the raw packet look information (as a string), as seen in npc_list and mob_pools
        -- look = "0x0100020500101120003000400050006000700000",

        -- Set the position using in-game x, y and z
        x = 191.660,
        y = -12.000,
        z = 229.149,

        -- Rotation is scaled 0-255, with 0 being East
        rotation = 50,

        -- Overriding widescan is only available to NPCs.
        widescan = 1,

        -- onTrade and onTrigger can be hooked up to your dynamic entity,
        -- just like with regular entities. You can also omit these.
        onTrade = function(player, npc, trade)
            -- NOTE: We have to use getPacketName, because the regular name is modified and being used
            --     : for internal lookups
            player:PrintToPlayer("No, thanks!", 0, npc:getPacketName())
        end,

        -- The entity will not be "triggerable" unless you populate onTrigger
        onTrigger = function(player, npc)
            -- NOTE: We have to use getPacketName, because the regular name is modified and being used
            --     : for internal lookups
            player:PrintToPlayer("Welcome to the WingsXI 3.0 Alpha Stress Test!", 0,npc:getPacketName())
            player:PrintToPlayer("My name is Lilith and my job is to help testers learn about what we are trying to do.", 0,npc:getPacketName())
            player:PrintToPlayer("Testers are free to do whatever they want, but please follow directions given in server messages for objectives.", 0, npc:getPacketName())
            player:PrintToPlayer("Here are some useful commands to help you in testing:", 0, npc:getPacketName())
            player:PrintToPlayer("!zone (auto-translate zone name) will allow you to go between different zones easily.", 0, npc:getPacketName())
            player:PrintToPlayer("!changejob (Job Abv) (Level) changes your main job and level.", 0, npc:getPacketName())
            player:PrintToPlayer("!changesjob (Job Abv) (Level) will change your subjob. Please remember SJ level is MJ/2.", 0, npc:getPacketName())
            player:PrintToPlayer("!additem (itemID) {qty} allows you to add an item to your inventory.", 0, npc:getPacketName())
            player:PrintToPlayer("!setgil (amount) will set your gil to that amount.", 0, npc:getPacketName())
            player:PrintToPlayer("!release will allow you to get out of cutscenes you do not want to watch.", 0, npc:getPacketName())
            player:PrintToPlayer("!speed (1-200) will increase or decrease your speed. Default speed is 40, Flee is 100.", 0, npc:getPacketName())
            player:PrintToPlayer("!togglegm will turn on your GM flag.", 0, npc:getPacketName())
            player:PrintToPlayer("If you change jobs, use !capallskills.", 0, npc:getPacketName())
            player:PrintToPlayer("You can also use !goto (player) to go to your friends.", 0, npc:getPacketName())
        end,
    })

    -- Use the mob object however you like
    -- horro:getID() etc.
    -- We're not doing anything with it, so ignore this object
    utils.unused(Lili)
    utils.unused(Cait)
    utils.unused(Lilit)

    -- You could also just not capture the object
    -- zone:insertDynamicEntity({ ...
end)

m:addOverride("xi.zones.Northern_San_dOria.Zone.onInitialize", function(zone)

    -- Call the zone's original function for onInitialize
    super(zone)

    -- Insert NPC into zone
    local Lili = zone:insertDynamicEntity({

        -- NPC or MOB
        objtype = xi.objType.NPC,

        -- The name visible to players
        -- NOTE: Even if you plan on making the name invisible, we're using it internally for lookups
        --     : So populate it with something unique-ish even if you aren't going to use it.
        --     : You can then hide the name with entity:hideName(true)
        -- NOTE: This name CAN include spaces and underscores.
        name = "Lilisette",

        -- You can use regular model ids (See documentation/model_ids.txt, or play around with !costume)
        look = 3049,

        -- You can also use the raw packet look information (as a string), as seen in npc_list and mob_pools
        -- look = "0x0100020500101120003000400050006000700000",

        -- Set the position using in-game x, y and z
        x = 82.179,
        y = 0.000,
        z = 4.156,

        -- Rotation is scaled 0-255, with 0 being East
        rotation = 204,

        -- Overriding widescan is only available to NPCs.
        widescan = 1,

        -- onTrade and onTrigger can be hooked up to your dynamic entity,
        -- just like with regular entities. You can also omit these.
        onTrade = function(player, npc, trade)
            -- NOTE: We have to use getPacketName, because the regular name is modified and being used
            --     : for internal lookups
            player:PrintToPlayer("No, thanks!", 0, npc:getPacketName())
        end,

        -- The entity will not be "triggerable" unless you populate onTrigger
        onTrigger = function(player, npc)
            -- NOTE: We have to use getPacketName, because the regular name is modified and being used
            --     : for internal lookups
            if player:getCharVar(string.format("[Alpha]Talked_to_%s", npc:getName())) ~= 1 then
                player:PrintToPlayer("Welcome to the WingsXI 3.0 Alpha Stress Test!", 0,npc:getPacketName())
                player:PrintToPlayer("To help you get on your way with testing I will be able to set your level to 99, SAM/WAR, and equipement.", 0,npc:getPacketName())
                player:PrintToPlayer("Just talk to me again to start the process.", 0, npc:getPacketName())
                player:setCharVar(string.format("[ALPHA]Talked_to_%s", npc:getName()), 1)
            elseif player:getCharVar(string.format("[Alpha]Talked_to_%s", npc:getName())) == 1 then
                local equipmentList =
                {
                    21956, -- Weapon Main
                    22212, -- Sub
                    21371, -- Ammo
                    25569, -- Head
                    25485, -- Neck
                    27544, -- Ear1
                    27545, -- Ear2
                    25733, -- Body
                    23520, -- Hands
                    26185, -- Ring1
                    26182, -- Ring2
                    26257, -- Back
                    28428, -- Waist
                    25856, -- Legs
                    27472, -- Feet
                }

                local ValidSpells =
                {
                    -- Spells
                    1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37,
                    38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71,
                    72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104,
                    105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130,
                    131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156,
                    157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182,
                    183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207, 208,
                    209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234,
                    235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255, 256, 257, 258, 259, 260,
                    261, 262, 263, 264, 265, 266, 267, 268, 269, 270, 271, 272, 273, 274, 275, 276, 277, 278, 279, 280, 281, 282, 283, 284, 285, 286,
                    287, 288, 289, 290, 291, 292, 293, 294, 295, 296, 297, 298, 299, 300, 301, 302, 303, 304, 305, 306, 307, 308, 309, 310, 311, 312,
                    313, 314, 315, 316, 317, 318, 319, 320, 321, 322, 323, 324, 325, 326, 327, 328, 329, 330, 331, 332, 333, 334, 335, 336, 337, 338,
                    339, 340, 341, 342, 343, 344, 345, 346, 347, 348, 349, 350, 351, 352, 353, 354, 355, 356, 357, 358, 359, 360, 361, 362, 363, 364,
                    365, 366, 367, 368, 369, 370, 371, 372, 373, 374, 375, 376, 377, 378, 379, 380, 381, 382, 383, 384, 385, 386, 387, 388, 389, 390,
                    391, 392, 393, 394, 395, 396, 397, 398, 399, 400, 401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 412, 413, 414, 415, 416,
                    417, 418, 419, 420, 421, 422, 423, 424, 425, 426, 427, 428, 429, 430, 431, 432, 433, 434, 435, 436, 437, 438, 439, 440, 441, 442,
                    443, 444, 445, 446, 447, 448, 449, 450, 451, 452, 453, 454, 455, 456, 457, 458, 459, 460, 461, 462, 463, 464, 465, 466, 467, 468,
                    469, 470, 471, 472, 473, 474, 475, 476, 477, 478, 479, 480, 481, 482, 483, 484, 485, 486, 487, 488, 489, 490, 491, 492, 493, 494,
                    495, 496, 497, 498, 499, 500, 501, 502, 503, 504, 505, 506, 507, 508, 509, 510, 511, 512, 513, 515, 517, 519, 521, 522, 524, 527,
                    529, 530, 531, 532, 533, 534, 535, 536, 537, 538, 539, 540, 541, 542, 543, 544, 545, 547, 548, 549, 551, 554, 555, 557, 560, 561,
                    563, 564, 565, 567, 569, 570, 572, 573, 574, 575, 576, 577, 578, 579, 581, 582, 584, 585, 587, 588, 589, 591, 592, 593, 594, 595,
                    596, 597, 598, 599, 603, 604, 605, 606, 608, 610, 611, 612, 613, 614, 615, 616, 617, 618, 620, 621, 622, 623, 626, 628, 629, 631,
                    632, 633, 634, 636, 637, 638, 640, 641, 642, 643, 644, 645, 646, 647, 648, 649, 650, 651, 652, 653, 654, 655, 656, 657, 658, 659,
                    660, 661, 662, 663, 664, 665, 666, 667, 668, 669, 670, 671, 672, 673, 674, 675, 676, 677, 678, 679, 680, 681, 682, 683, 684, 685,
                    686, 687, 688, 689, 690, 691, 692, 693, 694, 695, 696, 697, 698, 699, 700, 701, 702, 703, 704, 705, 706, 707, 708, 709, 710, 711,
                    712, 713, 714, 715, 716, 717, 718, 719, 720, 721, 722, 723, 724, 725, 726, 727, 728, 736, 737, 738, 739, 740, 741, 742, 743, 744,
                    745, 746, 747, 748, 749, 768, 769, 770, 771, 772, 773, 774, 775, 776, 777, 778, 779, 780, 781, 782, 783, 784, 785, 786, 787, 788,
                    789, 790, 791, 792, 793, 794, 795, 796, 797, 798, 799, 800, 801, 802, 803, 804, 805, 806, 807, 808, 809, 810, 811, 812, 813, 814,
                    815, 816, 817, 818, 819, 820, 821, 822, 823, 824, 825, 826, 827, 828, 829, 830, 831, 832, 833, 834, 835, 836, 837, 838, 839, 840,
                    841, 842, 843, 844, 845, 846, 847, 848, 849, 850, 851, 852, 853, 854, 855, 856, 857, 858, 859, 860, 861, 862, 863, 864, 865, 866,
                    867, 868, 869, 870, 871, 872, 873, 874, 875, 876, 877, 878, 879, 880, 881, 882, 883, 884, 885, 886, 887, 888, 889, 890, 891, 892,
                    893, 894, 895,
                }
                
                player:changeContainerSize(xi.inv.INVENTORY, 80)
                player:changeJob(xi.job.SAM)
                player:changesJob(xi.job.WAR)
                player:setLevel(99)
                player:setsLevel(player:getMainLvl()/2)
                player:capAllSkills()
                player:unkillable(true)

                for i = 1, #ValidSpells do
                    if i == #ValidSpells then
                        silent = false
                    end
            
                    player:addSpell(ValidSpells[i], silent, save, sendUpdate)
                end

                for i = 1, 49 do
                    player:addLearnedWeaponskill(i)
                end

                for _, item in pairs(equipmentList) do
                    player:addItem(item, 1)
                end
            end
        end,
    })

    local Cait = zone:insertDynamicEntity({

        -- NPC or MOB
        objtype = xi.objType.NPC,

        -- The name visible to players
        -- NOTE: Even if you plan on making the name invisible, we're using it internally for lookups
        --     : So populate it with something unique-ish even if you aren't going to use it.
        --     : You can then hide the name with entity:hideName(true)
        -- NOTE: This name CAN include spaces and underscores.
        name = "Cait Sith",

        -- You can use regular model ids (See documentation/model_ids.txt, or play around with !costume)
        look = 2197,

        -- You can also use the raw packet look information (as a string), as seen in npc_list and mob_pools
        -- look = "0x0100020500101120003000400050006000700000",

        -- Set the position using in-game x, y and z
        x = 78.948,
        y = 0.000,
        z = 7.239,

        -- Rotation is scaled 0-255, with 0 being East
        rotation = 204,

        -- Overriding widescan is only available to NPCs.
        widescan = 1,

        -- onTrade and onTrigger can be hooked up to your dynamic entity,
        -- just like with regular entities. You can also omit these.
        onTrade = function(player, npc, trade)
            -- NOTE: We have to use getPacketName, because the regular name is modified and being used
            --     : for internal lookups
            player:PrintToPlayer("No, thanks!", 0, npc:getPacketName())
        end,

        -- The entity will not be "triggerable" unless you populate onTrigger
        onTrigger = function(player, npc)
            -- NOTE: We have to use getPacketName, because the regular name is modified and being used
            --     : for internal lookups
            if player:getCharVar(string.format("[Alpha]Talked_to_%s", npc:getName())) ~= 1 then
                player:PrintToPlayer("Welcome to the WingsXI 3.0 Alpha Stress Test!", 0,npc:getPacketName())
                player:PrintToPlayer("To help you get on your way with testing I will be able to set your level to 99, SCH/RDM, and equipement.", 0,npc:getPacketName())
                player:PrintToPlayer("Just talk to me again to start the process.", 0, npc:getPacketName())
                player:setCharVar(string.format("[ALPHA]Talked_to_%s", npc:getName()), 1)
            elseif player:getCharVar(string.format("[Alpha]Talked_to_%s", npc:getName())) == 1 then
                local equipmentList =
                {
                    21150, -- Weapon Main
                    22213, -- Sub
                    22271, -- Ammo
                    23417, -- Head
                    25533, -- Neck
                    26085, -- Ear1
                    27526, -- Ear2
                    25689, -- Body
                    27120, -- Hands
                    26194, -- Ring1
                    27563, -- Ring2
                    26265, -- Back
                    28419, -- Waist
                    27305, -- Legs
                    27476, -- Feet
                }

                local ValidSpells =
                {
                    -- Spells
                    1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37,
                    38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71,
                    72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104,
                    105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130,
                    131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156,
                    157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182,
                    183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207, 208,
                    209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234,
                    235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255, 256, 257, 258, 259, 260,
                    261, 262, 263, 264, 265, 266, 267, 268, 269, 270, 271, 272, 273, 274, 275, 276, 277, 278, 279, 280, 281, 282, 283, 284, 285, 286,
                    287, 288, 289, 290, 291, 292, 293, 294, 295, 296, 297, 298, 299, 300, 301, 302, 303, 304, 305, 306, 307, 308, 309, 310, 311, 312,
                    313, 314, 315, 316, 317, 318, 319, 320, 321, 322, 323, 324, 325, 326, 327, 328, 329, 330, 331, 332, 333, 334, 335, 336, 337, 338,
                    339, 340, 341, 342, 343, 344, 345, 346, 347, 348, 349, 350, 351, 352, 353, 354, 355, 356, 357, 358, 359, 360, 361, 362, 363, 364,
                    365, 366, 367, 368, 369, 370, 371, 372, 373, 374, 375, 376, 377, 378, 379, 380, 381, 382, 383, 384, 385, 386, 387, 388, 389, 390,
                    391, 392, 393, 394, 395, 396, 397, 398, 399, 400, 401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 412, 413, 414, 415, 416,
                    417, 418, 419, 420, 421, 422, 423, 424, 425, 426, 427, 428, 429, 430, 431, 432, 433, 434, 435, 436, 437, 438, 439, 440, 441, 442,
                    443, 444, 445, 446, 447, 448, 449, 450, 451, 452, 453, 454, 455, 456, 457, 458, 459, 460, 461, 462, 463, 464, 465, 466, 467, 468,
                    469, 470, 471, 472, 473, 474, 475, 476, 477, 478, 479, 480, 481, 482, 483, 484, 485, 486, 487, 488, 489, 490, 491, 492, 493, 494,
                    495, 496, 497, 498, 499, 500, 501, 502, 503, 504, 505, 506, 507, 508, 509, 510, 511, 512, 513, 515, 517, 519, 521, 522, 524, 527,
                    529, 530, 531, 532, 533, 534, 535, 536, 537, 538, 539, 540, 541, 542, 543, 544, 545, 547, 548, 549, 551, 554, 555, 557, 560, 561,
                    563, 564, 565, 567, 569, 570, 572, 573, 574, 575, 576, 577, 578, 579, 581, 582, 584, 585, 587, 588, 589, 591, 592, 593, 594, 595,
                    596, 597, 598, 599, 603, 604, 605, 606, 608, 610, 611, 612, 613, 614, 615, 616, 617, 618, 620, 621, 622, 623, 626, 628, 629, 631,
                    632, 633, 634, 636, 637, 638, 640, 641, 642, 643, 644, 645, 646, 647, 648, 649, 650, 651, 652, 653, 654, 655, 656, 657, 658, 659,
                    660, 661, 662, 663, 664, 665, 666, 667, 668, 669, 670, 671, 672, 673, 674, 675, 676, 677, 678, 679, 680, 681, 682, 683, 684, 685,
                    686, 687, 688, 689, 690, 691, 692, 693, 694, 695, 696, 697, 698, 699, 700, 701, 702, 703, 704, 705, 706, 707, 708, 709, 710, 711,
                    712, 713, 714, 715, 716, 717, 718, 719, 720, 721, 722, 723, 724, 725, 726, 727, 728, 736, 737, 738, 739, 740, 741, 742, 743, 744,
                    745, 746, 747, 748, 749, 768, 769, 770, 771, 772, 773, 774, 775, 776, 777, 778, 779, 780, 781, 782, 783, 784, 785, 786, 787, 788,
                    789, 790, 791, 792, 793, 794, 795, 796, 797, 798, 799, 800, 801, 802, 803, 804, 805, 806, 807, 808, 809, 810, 811, 812, 813, 814,
                    815, 816, 817, 818, 819, 820, 821, 822, 823, 824, 825, 826, 827, 828, 829, 830, 831, 832, 833, 834, 835, 836, 837, 838, 839, 840,
                    841, 842, 843, 844, 845, 846, 847, 848, 849, 850, 851, 852, 853, 854, 855, 856, 857, 858, 859, 860, 861, 862, 863, 864, 865, 866,
                    867, 868, 869, 870, 871, 872, 873, 874, 875, 876, 877, 878, 879, 880, 881, 882, 883, 884, 885, 886, 887, 888, 889, 890, 891, 892,
                    893, 894, 895,
                }
                
                player:changeContainerSize(xi.inv.INVENTORY, 80)
                player:changeJob(xi.job.SCH)
                player:changesJob(xi.job.RDM)
                player:setLevel(99)
                player:setsLevel(player:getMainLvl()/2)
                player:capAllSkills()
                player:unkillable(true)

                for i = 1, #ValidSpells do
                    if i == #ValidSpells then
                        silent = false
                    end
            
                    player:addSpell(ValidSpells[i], silent, save, sendUpdate)
                end

                for i = 1, 49 do
                    player:addLearnedWeaponskill(i)
                end

                for _, item in pairs(equipmentList) do
                    player:addItem(item, 1)
                end
            end
        end,
    })

    local Lilit = zone:insertDynamicEntity({

        -- NPC or MOB
        objtype = xi.objType.NPC,

        -- The name visible to players
        -- NOTE: Even if you plan on making the name invisible, we're using it internally for lookups
        --     : So populate it with something unique-ish even if you aren't going to use it.
        --     : You can then hide the name with entity:hideName(true)
        -- NOTE: This name CAN include spaces and underscores.
        name = "Lilith",

        -- You can use regular model ids (See documentation/model_ids.txt, or play around with !costume)
        look = 2289,

        -- You can also use the raw packet look information (as a string), as seen in npc_list and mob_pools
        -- look = "0x0100020500101120003000400050006000700000",

        -- Set the position using in-game x, y and z
        x = 74.813,
        y = 0.000,
        z = 11.578,

        -- Rotation is scaled 0-255, with 0 being East
        rotation = 204,

        -- Overriding widescan is only available to NPCs.
        widescan = 1,

        -- onTrade and onTrigger can be hooked up to your dynamic entity,
        -- just like with regular entities. You can also omit these.
        onTrade = function(player, npc, trade)
            -- NOTE: We have to use getPacketName, because the regular name is modified and being used
            --     : for internal lookups
            player:PrintToPlayer("No, thanks!", 0, npc:getPacketName())
        end,

        -- The entity will not be "triggerable" unless you populate onTrigger
        onTrigger = function(player, npc)
            -- NOTE: We have to use getPacketName, because the regular name is modified and being used
            --     : for internal lookups
            player:PrintToPlayer("Welcome to the WingsXI 3.0 Alpha Stress Test!", 0,npc:getPacketName())
            player:PrintToPlayer("My name is Lilith and my job is to help testers learn about what we are trying to do.", 0,npc:getPacketName())
            player:PrintToPlayer("Testers are free to do whatever they want, but please follow directions given in server messages for objectives.", 0, npc:getPacketName())
            player:PrintToPlayer("Here are some useful commands to help you in testing:", 0, npc:getPacketName())
            player:PrintToPlayer("!zone (auto-translate zone name) will allow you to go between different zones easily.", 0, npc:getPacketName())
            player:PrintToPlayer("!changejob (Job Abv) (Level) changes your main job and level.", 0, npc:getPacketName())
            player:PrintToPlayer("!changesjob (Job Abv) (Level) will change your subjob. Please remember SJ level is MJ/2.", 0, npc:getPacketName())
            player:PrintToPlayer("!additem (itemID) {qty} allows you to add an item to your inventory.", 0, npc:getPacketName())
            player:PrintToPlayer("!setgil (amount) will set your gil to that amount.", 0, npc:getPacketName())
            player:PrintToPlayer("!release will allow you to get out of cutscenes you do not want to watch.", 0, npc:getPacketName())
            player:PrintToPlayer("!speed (1-200) will increase or decrease your speed. Default speed is 40, Flee is 100.", 0, npc:getPacketName())
            player:PrintToPlayer("!togglegm will turn on your GM flag.", 0, npc:getPacketName())
            player:PrintToPlayer("If you change jobs, use !capallskills.", 0, npc:getPacketName())
            player:PrintToPlayer("You can also use !goto (player) to go to your friends.", 0, npc:getPacketName())
        end,
    })

    -- Use the mob object however you like
    -- horro:getID() etc.
    -- We're not doing anything with it, so ignore this object
    utils.unused(Lili)
    utils.unused(Cait)
    utils.unused(Lilit)

    -- You could also just not capture the object
    -- zone:insertDynamicEntity({ ...
end)

return m