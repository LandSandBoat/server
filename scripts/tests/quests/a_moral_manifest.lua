-----------------------------------
-- A Moral Manifest
--
-- Zoning into the Altar Room at level 60 or above offers the quest. Hooknox offers it too.
-- Ponono takes a velvet cloth, a rainbow cloth and 10,000 gil, and the cutting is ready
-- at the next Vana'diel midnight. No zone change is required.
-- The reminders alternate with Ponono's guild master menu on successive clicks.
-- Event 704 sells a replacement cutting for 100,000 gil, and only plays once the player
-- holds neither the cutting nor the headgear made from it.
-- The offer is withheld while another beastman headgear quest is accepted or while a
-- hero headpiece is equipped.
--
-- Source: https://wiki.ffo.jp/html/15809.html
-----------------------------------
local questLog = xi.questLog.OTHER_AREAS
local questId  = xi.quest.id.otherAreas.A_MORAL_MANIFEST
local progVar  = 'Quest[4][108]Prog'

describe('Quest: A Moral Manifest', function()
    ---@type CClientEntityPair
    local player

    -- Fresh characters get the expansion intro cutscenes on zone-in. Complete the
    -- expansions up front so they cannot interrupt the quest events.
    local function spawnQuestPlayer(level)
        local questPlayer = xi.test.world:spawnPlayer({ level = level })
        questPlayer:addMission(xi.mission.log_id.ASA, xi.mission.id.asa.BURGEONING_DREAD)
        questPlayer:addMission(xi.mission.log_id.ACP, xi.mission.id.acp.A_CRYSTALLINE_PROPHECY_FIN)
        questPlayer:addMission(xi.mission.log_id.ROV, xi.mission.id.rov.A_RHAPSODY_FOR_THE_AGES)
        questPlayer:addMission(xi.mission.log_id.SOA, xi.mission.id.soa.ABOMINATION)

        return questPlayer
    end

    before_each(function()
        player = spawnQuestPlayer(99)
    end)

    -- Zone in and accept the offer cutscene.
    local function acceptQuest()
        player:gotoZone(xi.zone.ALTAR_ROOM)
        player.events:expect({ eventId = 46, finishOption = 0 })
        assert(player:getQuestStatus(questLog, questId) == xi.questStatus.QUEST_ACCEPTED, 'quest was not accepted')
    end

    -- Hear the instructions, then hand over the materials.
    local function tradeMaterials()
        -- Pin the clock early in the Vana'diel day so the wait cannot expire mid-test.
        xi.test.world:setVanaTime(1, 0)
        player:addItem(xi.item.SQUARE_OF_VELVET_CLOTH)
        player:addItem(xi.item.SQUARE_OF_RAINBOW_CLOTH)
        player:addItem(xi.item.GIL, 10000)
        player:gotoZone(xi.zone.WINDURST_WOODS)
        player.entities:gotoAndTrigger('Ponono', { eventId = 700, finishOption = 0 })
        player.actions:tradeNpc('Ponono',
        {
            xi.item.SQUARE_OF_VELVET_CLOTH,
            xi.item.SQUARE_OF_RAINBOW_CLOTH,
            { itemId = xi.item.GIL, quantity = 10000 },
        }, { eventId = 702, finishOption = 0 })
    end

    -- Wait out the Vana'diel midnight and pick up the cutting.
    local function collectCutting()
        xi.test.world:tick(xi.tick.VANA_DAY)
        xi.test.world:tick(xi.tick.VANA_HOUR)
        player.entities:gotoAndTrigger('Ponono', { eventId = 705, finishOption = 0 })
        player.assert:hasItem(xi.item.YAGUDO_HEADDRESS_CUTTING)
    end

    -- Craft the disguise and run the Altar Room half up to the completion zone-in.
    local function runAltarRoomHalf()
        player:delItem(xi.item.YAGUDO_HEADDRESS_CUTTING, 1)
        player:addItem(xi.item.YAGUDO_HEADGEAR)
        player:equipItem(xi.item.YAGUDO_HEADGEAR)
        player:gotoZone(xi.zone.ALTAR_ROOM)
        player.events:expect({ eventId = 47, finishOption = 0 })

        player.entities:gotoAndTrigger('Stone_Lid', { eventId = 48, finishOption = 0 })

        -- A cutscene actor shares the avatar's name. Fetch the mob by its ID.
        local avatar = player.entities:get(zones[xi.zone.ALTAR_ROOM].mob.YAGUDO_AVATAR)
        avatar.assert:isAlive()
        player:claimAndKillMob(avatar, { waitForDespawn = true })

        -- The stone lid unhides one second after the avatar despawns.
        xi.test.world:skipTime(2)

        player.entities:gotoAndTrigger('Stone_Lid', { eventId = 49, finishOption = 0 })
        player:unequipItem(xi.slot.HEAD)
        player.actions:tradeNpc('Stone_Lid', { xi.item.YAGUDO_HEADGEAR }, { eventId = 50, finishOption = 0 })

        player:equipItem(xi.item.TSOO_HAJAS_HEADGEAR)
        player:gotoZone(xi.zone.WINDURST_WOODS)
        player:gotoZone(xi.zone.ALTAR_ROOM)
        player.events:expect({ eventId = 51, finishOption = 0 })
    end

    it('offers the quest on zone-in at exactly level 60', function()
        player = spawnQuestPlayer(60)
        acceptQuest()
    end)

    it('withholds the offer below level 60', function()
        player = spawnQuestPlayer(59)
        player:gotoZone(xi.zone.ALTAR_ROOM)
        player.events:expectNotInEvent()
    end)

    it('withholds the offer while a hero headpiece is equipped', function()
        player:addItem(xi.item.TSOO_HAJAS_HEADGEAR)
        player:equipItem(xi.item.TSOO_HAJAS_HEADGEAR)
        player:gotoZone(xi.zone.ALTAR_ROOM)
        player.events:expectNotInEvent()
    end)

    it('withholds the offer while another beastman headgear quest is accepted', function()
        player:addQuest(questLog, xi.quest.id.otherAreas.A_GENEROUS_GENERAL)
        player:gotoZone(xi.zone.ALTAR_ROOM)
        player.events:expectNotInEvent()
    end)

    it('withholds the offer until the next tally after declining', function()
        player:gotoZone(xi.zone.ALTAR_ROOM)
        player.events:expect({ eventId = 46, finishOption = 1 })
        assert(player:getQuestStatus(questLog, questId) == xi.questStatus.QUEST_AVAILABLE, 'declining accepted the quest')

        player:gotoZone(xi.zone.WINDURST_WOODS)
        player:gotoZone(xi.zone.ALTAR_ROOM)
        player.events:expectNotInEvent()
    end)

    it('consumes the two cloths and 10,000 gil at the trade', function()
        acceptQuest()
        local startGil = player:getGil()
        tradeMaterials()
        player.assert.no:hasItem(xi.item.SQUARE_OF_VELVET_CLOTH)
        player.assert.no:hasItem(xi.item.SQUARE_OF_RAINBOW_CLOTH)
        assert(player:getGil() == startGil, 'the 10,000 gil was not consumed')
        assert(player:getCharVar(progVar) == 2, 'trade did not advance the quest')
    end)

    it('hands over the cutting after Vana midnight without a zone change', function()
        acceptQuest()
        tradeMaterials()
        player.entities:gotoAndTrigger('Ponono', { eventId = 703, finishOption = 0 })
        collectCutting()
        assert(player:getCharVar(progVar) == 3, 'the cutting did not advance the quest')
    end)

    it('alternates the waiting reminder with the guild master menu', function()
        acceptQuest()
        tradeMaterials()
        player.entities:gotoAndTrigger('Ponono', { eventId = 703, finishOption = 0 })
        player.entities:gotoAndTrigger('Ponono', { eventId = 10011, finishOption = 0 })
        player.entities:gotoAndTrigger('Ponono', { eventId = 703, finishOption = 0 })
    end)

    it('cancels the quest from the reminder', function()
        acceptQuest()
        player:gotoZone(xi.zone.WINDURST_WOODS)
        player.entities:gotoAndTrigger('Ponono', { eventId = 700, finishOption = 0 })
        player.entities:gotoAndTrigger('Ponono', { eventId = 701, finishOption = 100 })
        assert(player:getQuestStatus(questLog, questId) == xi.questStatus.QUEST_AVAILABLE, 'cancel did not remove the quest')
        assert(player:getCharVar(progVar) == 0, 'cancel did not wipe the quest vars')
    end)

    it('sells a replacement cutting for 100,000 gil once both items are gone', function()
        acceptQuest()
        tradeMaterials()
        collectCutting()

        -- Holding the cutting: guild master menu only.
        player.entities:gotoAndTrigger('Ponono', { eventId = 10011, finishOption = 0 })

        -- Holding the crafted headgear instead: still not lost.
        player:delItem(xi.item.YAGUDO_HEADDRESS_CUTTING, 1)
        player:addItem(xi.item.YAGUDO_HEADGEAR)
        player.entities:gotoAndTrigger('Ponono', { eventId = 10011, finishOption = 0 })

        -- Both gone with no gil: the offer plays and nothing is charged.
        player:delItem(xi.item.YAGUDO_HEADGEAR, 1)
        local brokeGil = player:getGil()
        player.entities:gotoAndTrigger('Ponono', { eventId = 704, finishOption = 0 })
        assert(player:getGil() == brokeGil, 'an unaffordable replacement charged gil')
        assert(player:getCharVar(progVar) == 3, 'an unaffordable replacement advanced the quest')

        -- The failed offer alternates back to the menu.
        player.entities:gotoAndTrigger('Ponono', { eventId = 10011, finishOption = 0 })

        -- Paid: 100,000 gil deducted and the wait starts over.
        player:addItem(xi.item.GIL, 100000)
        local paidGil = player:getGil()
        player.entities:gotoAndTrigger('Ponono', { eventId = 704, finishOption = 0 })
        assert(player:getGil() == paidGil - 100000, 'the replacement did not cost 100,000 gil')
        assert(player:getCharVar(progVar) == 2, 'the replacement did not restart the wait')
        collectCutting()
    end)

    it('completes the Altar Room half and rewards the gold beastcoin', function()
        acceptQuest()
        tradeMaterials()
        collectCutting()
        runAltarRoomHalf()

        assert(player:hasCompletedQuest(questLog, questId), 'the quest did not complete')
        player.assert:hasItem(xi.item.GOLD_BEASTCOIN)
        player.assert:hasItem(xi.item.TSOO_HAJAS_HEADGEAR)
        player.assert.no:hasItem(xi.item.YAGUDO_HEADGEAR)
        assert(not player:hasKeyItem(xi.ki.VAULT_QUIPUS), 'the vault quipus was not taken')
        assert(player:getCharVar(progVar) == 0, 'completion did not wipe the quest vars')
    end)

    it('does not re-offer the quest after completion', function()
        acceptQuest()
        tradeMaterials()
        collectCutting()
        runAltarRoomHalf()

        -- Zoning back in no longer offers the quest.
        player:gotoZone(xi.zone.WINDURST_WOODS)
        player:gotoZone(xi.zone.ALTAR_ROOM)
        player.events:expectNotInEvent()
        assert(player:getCharVar(progVar) == 0, 'a completed player restarted the quest')

        -- Ponono is a guild master again.
        player:gotoZone(xi.zone.WINDURST_WOODS)
        player.entities:gotoAndTrigger('Ponono', { eventId = 10011, finishOption = 0 })
    end)
end)
