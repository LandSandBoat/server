-----------------------------------
-- Area: Selbina
--  NPC: Zaldon
-- Involved in Quests: Under the sea, A Boy's Dream
-- Starts and Finishes: Inside the Belly
-- !pos -13 -7 -5 248
-----------------------------------
---@type TNpcEntity
local entity = {}

-- data from http://wiki.ffxiclopedia.org/wiki/Inside_the_Belly
local fishRewards =
{
    [4304] = -- Grimmonite
    {
        gil = 350,
        items =
        {
            { chance = 5, itemId = 13445 }, -- Gold Ring (guessing 5%. Wiki unknown.)
            { chance = 5, itemId = 13446 }, -- Mythril Ring (guessing 5%. Wiki unknown.)
            { chance = 5, itemId = 13456 }, -- Silver Ring (guessing 5%. Wiki unknown.)
        }
    },

    [4305] = -- Ryugu Titan
    {
        gil = 800,
        items =
        {
            { chance = 1.3, itemId = 18377 }, -- Mercurial Sword
        }
    },

    [4306] = -- Giant Donko
    {
        gil = 96,
        items =
        {
            { chance = 4.7, itemId = 1833 }, -- Broken Halcyon Fishing Rod
        }
    },

    [4307] = -- Jungle Catfish
    {
        gil = 300,
        items =
        {
            { chance = 3, itemId = 1832 }, -- Broken Hume Fishing Rod
        }
    },

    [4308] = -- Giant Chirai
    {
        gil = 550,
        items =
        {
            { chance = 1.2, itemId = 1278 }, -- Spool of Twinthread
        }
    },

    [4309] = -- Cave Cherax
    {
        gil = 800,
        items =
        {
            { chance = 26.2, itemId = 17007 }, -- Dwarf Pugil
        }
    },

    [4316] = -- Armored Pisces
    {
        gil = 475,
        items =
        {
            { chance = 0.4, itemId = 13736 }, -- Stolid Breastplate
        }
    },

    [4319] = -- Tricorn
    {
        gil = 810,
        items =
        {
            { chance = 4, itemId = 645 }, -- Chunk of Darksteel Ore (guessing 4%. Wiki unknown.)
        }
    },

    [4385] = -- Zafmlug Bass
    {
        gil = 15,
        items =
        {
            { chance = 1.4, itemId = 770 }, -- Blue Rock
        }
    },

    [4462] = -- Monke-Onke
    {
        gil = 150,
        items =
        {
            { chance = 10, itemId = 943, min = 1, max = 6 }, -- Pinch of Poison Dust (guessing 10%. Wiki unknown.)
        }
    },

    [4428] = -- Dark Bass
    {
        gil = 10,
        items =
        {
            { chance = 4.6, itemId = 772 }, -- Green Rock
        }
    },

    [4451] = -- Silver Shark
    {
        gil = 250,
        title = xi.title.ACE_ANGLER,
        items =
        {
            { chance = 1.4, itemId = 16837 }, -- Trident
        }
    },

    [4454] = -- Emperor Fish
    {
        gil = 300,
        items =
        {
            { chance = 1, itemId = 12955 }, -- Cuir Highboots (guessing 1%. Wiki says 0%.)
        }
    },

    [4463] = -- Takitaro
    {
        gil = 350,
        items =
        {
            { chance = 2.4, itemId = 942 }, -- Philosopher's Stone
        }
    },

    [4471] = -- Bladefish
    {
        gil = 200,
        items =
        {
            { chance = 11.7, itemId = 17002 }, -- Robber Rig
        }
    },

    [4474] = -- Gigant Squid
    {
        gil = 300,
        items =
        {
            { chance = 2.5, itemId = 12317 }, -- Flame Shield (guessing 2.5%. Wiki unknown.)
        }
    },

    [4475] = -- Sea Zombie
    {
        gil = 350,
        items =
        {
            { chance = 26.1, itemId = 17006 }, -- Drill Calamary
        }
    },

    [4476] = -- Titanictus
    {
        gil = 350,
        title = xi.title.LU_SHANG_LIKE_FISHER_KING,
        items =
        {
            { chance = 1.3, itemId = 16533 }, -- Ancient Sword
            { chance =   5, itemId =   888 }, -- Seashell (guessing 5%. Wiki unknown.)
        }
    },

    [4477] = -- Gavial Fish
    {
        gil = 250,
        items =
        {
            { chance = 4.9, itemId = 13361 }, -- Drone Earring
        }
    },

    [4478] = -- Three-eyed Fish
    {
        gil = 250,
        items =
        {
            { chance = 10, itemId = 945, min = 1, max = 10 }, -- Pinch of Paralysis Dust (guessing 10%. Wiki unknown.)
        }
    },

    [4479] = -- Bhefhel Marlin
    {
        gil = 150,
        items =
        {
            { chance = 14.3, itemId = 1873 }, -- Brigand's Chart
            { chance =  4.4, itemId = 1874 }, -- Pirate's Chart
        }
    },

    [4480] = -- Gugru Tuna
    {
        gil = 50,
        items =
        {
            { chance = 2.5, itemId = 19186 }, -- Tiny Tathlum
        }
    },

    [4481] = -- Ogre Eel
    {
        gil = 16,
        title = xi.title.CORDON_BLEU_FISHER,
        items =
        {
            { chance = 2.5, itemId = 13480 }, -- Turquoise Ring
        }
    },

    [5120] = -- Titanic Sawfish
    {
        gil = 810,
        items =
        {
            { chance = 0.7, itemId = 19290 }, -- Aizenkunitoshi
        }
    },

    [5127] = -- Gugrusaurus
    {
        gil = 880,
        items =
        {
            { chance = 0.4, itemId = 1837 }, -- Saber Shoot
        }
    },

    [5129] = -- Lik
    {
        gil = 880,
        items =
        {
            { chance = 0.5, itemId = 1826 }, -- Spool of Opal Silk
        }
    },

    [5133] = -- Pterygotus
    {
        gil = 390,
        items =
        {
            { chance = 6.7, itemId = 795 }, -- Lapis Lazuli
        }
    },

    [5134] = -- Mola Mola
    {
        gil = 487,
        items =
        {
            { chance = 1.8, itemId = 16850 }, -- Mercurial Spear
        }
    },

    [5135] = -- Rhinochimera
    {
        gil = 300,
        items =
        {
            { chance = 3.2, itemId = 11624 }, -- Solon Torque
        }
    },

    [5136] = -- Istavrit
    {
        gil = 50,
        items =
        {
            { chance = 10, itemId = 944, min = 1, max = 6 }, -- Pinch of Venom Dust (guessing 10%. Wiki unknown.)
        }
    },

    [5137] = -- Turnabaligi
    {
        gil = 340,
        items =
        {
            { chance =   1, itemId = 1262 }, -- Chunk of Dark Ore
            { chance = 1.4, itemId = 1256 }, -- Chunk of Ice Ore
            { chance = 1.4, itemId = 1260 }, -- Chunk of Water Ore
        }
    },

    [5140] = -- Kalkanbaligi
    {
        gil = 390,
        items =
        {
            { chance = 3.3, itemId = 16184 }, -- Flat Shield
        }
    },

    [5141] = -- Veydal Wrasse
    {
        gil = 225,
        items =
        {
            { chance = 5, itemId = 4361 }, -- Nebimonite (guessing 5%. Wiki unknown.)
            { chance = 5, itemId =  888 }, -- Seashell (guessing 5%. Wiki unknown.)
        }
    },

    [5450] = -- Lakerda
    {
        gil = 51,
        items =
        {
            { chance =   6, itemId = 792 }, -- Pearl
            { chance = 1.9, itemId = 793 }, -- Black Pearl
        }
    },

    [5451] = -- Kilicbaligi
    {
        gil = 150,
        items =
        {
            { chance = 2.5, itemId = 16606 }, -- Rusty Greatsword (guessing 2.5%. Wiki unknown.)
        }
    },

    [5455] = -- Ahtapot
    {
        gil = 350,
        items =
        {
            { chance = 18.5, itemId = 2886 }, -- Mildewy Ingot
            { chance = 10.2, itemId = 2887 }, -- Decayed Ingot
        }
    },

    [5462] = -- Morinabaligi
    {
        gil = 300,
        items =
        {
            { chance = 5, itemId = 12699 }, -- Cuir Gloves (guessing 5%. Wiki unknown.)
        }
    },

    [5463] = -- Yayinbaligi
    {
        gil = 50,
        items =
        {
            { chance = 5, itemId = 14649 }, -- Telluric Ring (guessing 5%. Wiki unknown.)
        }
    },

    [5467] = -- Megalodon
    {
        gil = 532,
        items =
        {
            { chance = 3, itemId =   483 }, -- Broken Mithran Fishing Rod (guessing 3%. Wiki unknown.)
            { chance = 3, itemId = 17380 }, -- Mithran Fishing Rod (guessing 3%. Wiki unknown.)
        }
    },

    [5468] = -- Matsya
    {
        gil = 12592,
        items =
        {
            { chance = 1.2, itemId = 11009 }, -- Shaper's Shawl
        }
    },

    [5470] = -- Pirarucu
    {
        gil = 516,
        items =
        {
            { chance =   5, itemId = 1122 }, -- Wyvern Skin (guessing 5%. Wiki unknown.)
            { chance = 2.5, itemId = 2523 }, -- Peiste Skin (guessing 2.5%. Wiki unknown.)
        }
    },

    [5471] = -- Gerrothorax
    {
        gil = 423,
        items =
        {
            { chance = 1.2, itemId = 11492 }, -- Risky Patch
        }
    },

    [5475] = -- Gigant Octopus
    {
        gil = 119,
        items =
        {
            { chance = 10, itemId = 929, min = 1, max = 6 }, -- Jar of Black Ink (guessing 10%. Wiki unknown.)
        }
    },

    [5476] = -- Abaia
    {
        gil = 690,
        items =
        {
            { chance =  1.5, itemId = 5818, min = 1, max = 1 }, -- Aurora Bass x3
            { chance =  7.8, itemId = 5818, min = 2, max = 2 }, -- Aurora Bass x2
            { chance = 12.5, itemId = 5818, min = 3, max = 3 }, -- Aurora Bass x1
            { chance =  0.7, itemId = 10372 }, -- Plumb Boots
        }
    },
    [5537] = -- Soryu
    {
        gil = 1512,
        items =
        {
            { chance = 46.8, itemId = 9099 }, -- Soryu's Liver
        }
    },

    [5538] = -- Sekiryu
    {
        gil = 1512,
        items =
        {
            { chance = 48.1, itemId = 9100 }, -- Sekiryu's Liver (guessing 48.1%. Wiki unknown.)
        }
    },

    [5539] = -- Hakuryu
    {
        gil = 1512,
        items =
        {
            { chance = 48.1, itemId = 9101 }, -- Hakuryu's Liver
        }
    },

    [4469] = -- Giant Catfish
    {
        gil = 50,
        title = xi.title.CORDON_BLEU_FISHER,
        items =
        {
            { chance = 6.2, itemId = 17076 }, -- Earth Wand
        }
    },

    [5813] = -- Dorado Gar
    {
        gil = 568,
        items =
        {
            { chance = 5, itemId = 745, min = 1, max = 4 }, -- Gold Ingot (guessing 5%. Wiki unknown.)
        }
    },

    [5814] = -- Crocodilos
    {
        gil = 1763,
        items =
        {
            { chance = 2.3, itemId = 11654 }, -- Puffin Ring
        }
    },

    [5815] = -- Pelazoea
    {
        gil = 360,
        items =
        {
            { chance = 1.8, itemId = 11655 }, -- Noddy Ring
        }
    },

    [6489] = -- Far East Puffer
    {
        gil = 735,
        items =
        {
            { chance = 5, itemId = 25864 }, -- Stinky Subligar (guessing 5%. Wiki unknown.)
        }
    },
}

local function tradeFish(player, fishId)
    player:setCharVar('insideBellyFishId', fishId)
    player:setCharVar('insideBellyItemIdx', 0)

    local rewards = fishRewards[fishId].items
    local roll    = math.random(1, 1000) / 10
    local found   = false
    local sum     = 0

    for i = 1, #rewards do
        sum = sum + rewards[i].chance
        if roll <= sum then
            found = true
            player:setCharVar('insideBellyItemIdx', i)

            -- NOTE: We confirm the trade now, and not at the end of the cutscene as normal
            --     : because the cutscene gives away whether or not the trade was successful
            --     : or not, and it's possible for players to cheese this trade by force-dc-ing.
            player:confirmTrade()
            player:startEvent(166, 0, rewards[i].itemId)
            break
        end
    end

    if not found then
        player:confirmTrade()
        player:startEvent(167)
    end
end

local function giveReward(player, csid)
    if csid == 166 or csid == 167 then
        local fishId  = player:getCharVar('insideBellyFishId')
        local itemIdx = player:getCharVar('insideBellyItemIdx')
        local reward  = fishRewards[fishId]
        local traded  = true

        if itemIdx > 0 then
            local r = reward.items[itemIdx]
            local itemId = r.itemId
            local itemQt = 1
            if r.min ~= nil and r.max ~= nil then
                itemQt = math.random(r.min, r.max)
            end

            if not npcUtil.giveItem(player, { { itemId, itemQt } }) then
                traded = false
            end
        end

        if traded then
            npcUtil.giveCurrency(player, 'gil', reward.gil)
            player:setCharVar('insideBellyFishId', 0)
            player:setCharVar('insideBellyItemIdx', 0)
            if player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.INSIDE_THE_BELLY) == xi.questStatus.QUEST_ACCEPTED then
                player:completeQuest(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.INSIDE_THE_BELLY)
            end

            if reward.title ~= nil then
                player:addTitle(reward.title)
            end
        end
    end
end

entity.onTrade = function(player, npc, trade)
    local insideTheBelly = player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.INSIDE_THE_BELLY)

    -- A BOY'S DREAM
    if
        player:getCharVar('aBoysDreamCS') == 5 and
        npcUtil.tradeHasExactly(trade, xi.item.ODONTOTYRANNUS)
    then
        player:startEvent(85)

    -- INSIDE THE BELLY
    elseif
        insideTheBelly == xi.questStatus.QUEST_ACCEPTED or
        insideTheBelly == xi.questStatus.QUEST_COMPLETED
    then
        for fish, v in pairs(fishRewards) do
            if npcUtil.tradeHas(trade, fish) then
                tradeFish(player, fish)
                break
            end
        end
    end
end

entity.onTrigger = function(player, npc)
    -- TODO: once fishing skill is implemented, replace all these mLvl checks with player:getSkillLevel(xi.skill.FISHING)

    local theRealGift    = player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.THE_REAL_GIFT)
    local insideTheBelly = player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.INSIDE_THE_BELLY)
    local mLvl           = player:getMainLvl()

    -- INSIDE THE BELLY
    if
        mLvl >= 30 and
        theRealGift == xi.questStatus.QUEST_COMPLETED and
        insideTheBelly == xi.questStatus.QUEST_AVAILABLE
    then
        player:startEvent(161)
    elseif
        mLvl >= 30 and
        mLvl < 39 and
        (insideTheBelly == xi.questStatus.QUEST_ACCEPTED or insideTheBelly == xi.questStatus.QUEST_COMPLETED)
    then
        player:startEvent(162, 5799, 4481, 5802, 4428)
    elseif
        mLvl >= 40 and
        mLvl < 49 and
        (insideTheBelly == xi.questStatus.QUEST_ACCEPTED or insideTheBelly == xi.questStatus.QUEST_COMPLETED)
    then
        player:startEvent(163, 5805, 4385, 5800, 5802, 5450) -- 5802(Istavrit) is skill cap 41, and therefore is used in this and the previous csid
    elseif
        mLvl >= 50 and
        mLvl <= 74 and
        (insideTheBelly == xi.questStatus.QUEST_ACCEPTED or insideTheBelly == xi.questStatus.QUEST_COMPLETED)
    then
        player:startEvent(164, 5806, 5451, 5801, 5804, 5807, 5135)
    elseif
        mLvl >= 75 and
        (insideTheBelly == xi.questStatus.QUEST_ACCEPTED or insideTheBelly == xi.questStatus.QUEST_COMPLETED)
    then
        player:startEvent(165, 4451, 4477, 5803, 4307, 4478, 5467, 4304, 4474)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    -- A BOY'S DREAM
    if csid == 85 then
        npcUtil.giveKeyItem(player, xi.ki.KNIGHTS_BOOTS)
        player:setCharVar('aBoysDreamCS', 6)
        player:confirmTrade()

    -- INSIDE THE BELLY
    elseif csid == 161 then
        player:addQuest(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.INSIDE_THE_BELLY)
    elseif csid == 166 or csid == 167 then
        giveReward(player, csid)
    end
end

return entity
