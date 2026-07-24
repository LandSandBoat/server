-----------------------------------
-- An Explorer's Footsteps (Quest ID: otherAreas.AN_EXPLORERS_FOOTSTEPS)
--
-- Regression coverage for issue #10817: Stone Monuments in Shadowreign (past-era
-- "[S]") zones don't respond to the Lump of Selbina Clay, even though retail lets
-- you press the same monument in the past and turn the tablet in for credit.
--
-- Retail model (ffxiclopedia / bg-wiki, cross-checked against npc_list.sql coords):
--   * 17 present-day monuments = the 17 quest slots.
--   * 8 [S] zones hold the SAME monument as a present-day slot; Abelard credits
--     them identically (Batallia Downs [S] -> slot 5, the zone in the issue).
--   * 3 [S]-only zones (Vunkerl Inlet, Grauberg, Fort Karugo-Narugo) are NOT part
--     of the quest -- pressing clay there yields no tablet according to ffxiclopedia.
--
-- Batallia's present-day monument slot index is 5 (xi.zone.BATALLIA_DOWNS in the
-- quest's monumentTable). Both the present-day and [S] tablet must credit slot 5.
-----------------------------------
local batalliaSlot = 5

describe("Quest: An Explorer's Footsteps", function()
    ---@type CClientEntityPair
    local player

    -- Drop the player straight into the accepted state (activates the monument
    -- section), unlock the past so [S] zone-ins don't collide with an expansion
    -- cutscene (mirrors tests/missions/wotg.lua), and hand over one fresh clay.
    local function acceptedWithClay()
        player = xi.test.world:spawnPlayer()
        player:setLevel(99)
        player:addMission(xi.mission.log_id.ASA, xi.mission.id.asa.BURGEONING_DREAD)
        player:addMission(xi.mission.log_id.ACP, xi.mission.id.acp.A_CRYSTALLINE_PROPHECY_FIN)
        player:addMission(xi.mission.log_id.ROV, xi.mission.id.rov.A_RHAPSODY_FOR_THE_AGES)
        player:addMission(xi.mission.log_id.SOA, xi.mission.id.soa.ABOMINATION)

        player:addQuest(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.AN_EXPLORERS_FOOTSTEPS)
        player:addItem({ id = xi.item.LUMP_OF_SELBINA_CLAY, quantity = 1 })
    end

    -- Press the clay into the Stone Monument in the current zone.
    local function pressClayAtMonument()
        player.actions:tradeNpc('Stone_Monument', { xi.item.LUMP_OF_SELBINA_CLAY })
    end

    -- Turn the resulting Clay Tablet in to Abelard in Selbina. With TargetMonument
    -- unset (0) and Batallia = slot 5, the "different monument than requested"
    -- branch fires -> event 46, finished with option 0 (no follow-up/abort).
    local function turnInToAbelard()
        player:gotoZone(xi.zone.SELBINA)
        player.actions:tradeNpc('Abelard', { xi.item.CLAY_TABLET }, { eventId = 46, finishOption = 0 })
    end

    before_each(function()
        acceptedWithClay()
    end)

    -- Tier 1 (control): the present-day monument already works end to end.
    it('credits the Batallia Downs monument tablet (present day)', function()
        player:gotoZone(xi.zone.BATALLIA_DOWNS)
        pressClayAtMonument()
        player.assert:hasItem(xi.item.CLAY_TABLET)
        player.assert.no:hasItem(xi.item.LUMP_OF_SELBINA_CLAY)

        turnInToAbelard()
        player.assert.no:hasItem(xi.item.CLAY_TABLET)
        assert(player:getCharVar('[EF]MonumentCount') == 1, 'present-day tablet was not credited')
        assert(utils.mask.getBit(player:getCharVar('[EF]MonumentBitmask'), batalliaSlot),
            'present-day tablet credited the wrong monument slot')
    end)

    -- Tier 2 (#10817): the Shadowreign monument must behave identically.
    -- FAILS on base -- the [S] monument gives no tablet, so there is nothing to
    -- turn in and no credit is recorded.
    it('credits the Batallia Downs (S) Shadowreign monument tablet identically', function()
        player:gotoZone(xi.zone.BATALLIA_DOWNS_S)
        pressClayAtMonument()
        player.assert:hasItem(xi.item.CLAY_TABLET)
        player.assert.no:hasItem(xi.item.LUMP_OF_SELBINA_CLAY)

        turnInToAbelard()
        player.assert.no:hasItem(xi.item.CLAY_TABLET)
        assert(player:getCharVar('[EF]MonumentCount') == 1, 'Shadowreign tablet was not credited')
        assert(utils.mask.getBit(player:getCharVar('[EF]MonumentBitmask'), batalliaSlot),
            'Shadowreign tablet credited the wrong monument slot')
    end)

    -- Tier 3 (guard against over-reach): a [S]-only monument is not part of the
    -- quest. Pressing clay must give no tablet and consume nothing. Passes on base
    -- today and must keep passing after the fix.
    it('leaves the Fort Karugo-Narugo (S) monument inert (not a quest monument)', function()
        player:gotoZone(xi.zone.FORT_KARUGO_NARUGO_S)
        pressClayAtMonument()
        player.assert.no:hasItem(xi.item.CLAY_TABLET)
        player.assert:hasItem(xi.item.LUMP_OF_SELBINA_CLAY)
    end)

    -- The two Batallia monuments are ONE slot, so a player who collected present-day Batallia can't double-dip via [S].
    it('treats Batallia Downs and Batallia Downs (S) as one monument (no double credit)', function()
        player:gotoZone(xi.zone.BATALLIA_DOWNS)
        pressClayAtMonument()
        turnInToAbelard()
        assert(player:getCharVar('[EF]MonumentCount') == 1, 'present-day Batallia was not credited')

        -- Same monument in the past -> Abelard rejects it as already-collected (event 45)
        -- and hands the clay back instead of counting slot 5 a second time.
        player:addItem({ id = xi.item.LUMP_OF_SELBINA_CLAY, quantity = 1 })
        player:gotoZone(xi.zone.BATALLIA_DOWNS_S)
        pressClayAtMonument()
        player.assert:hasItem(xi.item.CLAY_TABLET)
        player:gotoZone(xi.zone.SELBINA)
        player.actions:tradeNpc('Abelard', { xi.item.CLAY_TABLET }, { eventId = 45, finishOption = 0 })
        assert(player:getCharVar('[EF]MonumentCount') == 1, 'Batallia [S] double-credited an already-collected monument')
    end)

    -- Part B: examining a monument reads its inscription (event 900). Present-day works today.
    it('reads the inscription (event 900) at the present-day Batallia monument', function()
        player:gotoZone(xi.zone.BATALLIA_DOWNS)
        player.entities:gotoAndTrigger('Stone_Monument', { eventId = 900 })
    end)

    -- Part B: the Shadowreign monument must read its inscription too. FAILS until DefaultActions is wired.
    it('reads the inscription (event 900) at the Batallia Downs (S) monument', function()
        player:gotoZone(xi.zone.BATALLIA_DOWNS_S)
        player.entities:gotoAndTrigger('Stone_Monument', { eventId = 900 })
    end)
end)
