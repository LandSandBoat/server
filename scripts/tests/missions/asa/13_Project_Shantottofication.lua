local packetReader         = require('scripts.tests.helpers.packet_reader')
local sacrificialChamberID = zones[xi.zone.SACRIFICIAL_CHAMBER]

-- A sister's skill lands once she is in range and done readying it.
---@param player CClientEntityPair
---@param effect xi.effect
local function waitForEffect(player, effect)
    local waited = 0
    while not player:hasStatusEffect(effect) and waited < 10 do
        xi.test.world:skipTime(1)
        waited = waited + 1
    end
end

describe('ASA M13 - Project: Shantottofication', function()
    ---@type CClientEntityPair
    local player

    local tablets =
    {
        xi.keyItem.TABLET_OF_HEXES_GREED,
        xi.keyItem.TABLET_OF_HEXES_ENVY,
        xi.keyItem.TABLET_OF_HEXES_MALICE,
        xi.keyItem.TABLET_OF_HEXES_DECEIT,
        xi.keyItem.TABLET_OF_HEXES_PRIDE,
        xi.keyItem.TABLET_OF_HEXES_BALE,
        xi.keyItem.TABLET_OF_HEXES_DESPAIR,
        xi.keyItem.TABLET_OF_HEXES_REGRET,
        xi.keyItem.TABLET_OF_HEXES_RAGE,
        xi.keyItem.TABLET_OF_HEXES_AGONY,
        xi.keyItem.TABLET_OF_HEXES_DOLOR,
        xi.keyItem.TABLET_OF_HEXES_RANCOR,
        xi.keyItem.TABLET_OF_HEXES_STRIFE,
        xi.keyItem.TABLET_OF_HEXES_PENURY,
        xi.keyItem.TABLET_OF_HEXES_BLIGHT,
        xi.keyItem.TABLET_OF_HEXES_DEATH,
    }

    local function enter()
        player.bcnm:enter('_4j0', xi.battlefield.id.PROJECT_SHANTOTTOFICATION)

        -- The tablets are consumed on the first battlefield tick, a second after entry.
        xi.test.world:skipTime(2)
    end

    -- The win event comes on the battlefield tick after the last kill.
    local function win()
        player.bcnm:killMobs()
        xi.test.world:skipTime(2)
        player.bcnm:expectWin()
    end

    before_each(function()
        player = xi.test.world:spawnPlayer({ job = xi.job.WAR, level = 99, zone = xi.zone.SACRIFICIAL_CHAMBER })
        player:addMission(xi.mission.log_id.ASA, xi.mission.id.asa.PROJECT_SHANTOTTOFICATION)
        for _, tablet in ipairs(tablets) do
            player:addKeyItem(tablet)
        end
    end)

    it('absorbs every tablet on entry and buffs the player for the fight', function()
        local strength = player:getMod(xi.mod.STR)
        enter()

        for _, tablet in ipairs(tablets) do
            player.assert.no:hasKI(tablet)
        end

        player.assert:hasModifier(xi.mod.STR, strength + 150)
        player.assert:hasModifier(xi.mod.HPP, 200)
        player.assert:hasEffect(xi.effect.RERAISE)

        -- The buffs ride on the Battlefield effect and leave with it.
        player:gotoZone(xi.zone.SACRIFICIAL_CHAMBER)
        player.assert:hasModifier(xi.mod.STR, strength)
    end)

    it('scales the buffs with the tablets held', function()
        for i = 9, 16 do
            player:delKeyItem(tablets[i])
        end

        local strength = player:getMod(xi.mod.STR)
        enter()

        player.assert:hasModifier(xi.mod.STR, strength + 75)
        player.assert:hasModifier(xi.mod.HPP, 100)
    end)

    it('does not open without a tablet', function()
        for _, tablet in ipairs(tablets) do
            player:delKeyItem(tablet)
        end

        player.entities:gotoAndTrigger('_4j0')
        player.events:expectNotInEvent()
        assert(not player:getBattlefield(), 'Expected no battlefield without a tablet')
    end)

    it('does not open while the Tonberry key is held', function()
        player:addKeyItem(xi.keyItem.TONBERRY_KEY)

        player.packets:clear()
        player.entities:gotoAndTrigger('_4j0')
        player.events:expectNotInEvent()
        assert(packetReader.saidMessage(player, sacrificialChamberID.text.CANNOT_ENTER_WITH_KEY), 'Expected the Tonberry key refusal')
        assert(not player:getBattlefield(), 'Expected no battlefield with the Tonberry key')
        player.assert:hasKI(xi.keyItem.TABLET_OF_HEXES_GREED)
    end)

    it('gives the Tonberry key and completes the mission on a win', function()
        enter()
        win()

        player.assert:hasKI(xi.keyItem.TONBERRY_KEY)
        player.assert:hasMission(xi.mission.log_id.ASA, xi.mission.id.asa.AN_UNEASY_PEACE)
    end)

    it('buffs and rewards a party member who follows the leader in', function()
        local member = xi.test.world:spawnPlayer({ job = xi.job.WAR, level = 99, zone = xi.zone.SACRIFICIAL_CHAMBER })
        member:addMission(xi.mission.log_id.ASA, xi.mission.id.asa.PROJECT_SHANTOTTOFICATION)
        for _, tablet in ipairs(tablets) do
            member:addKeyItem(tablet)
        end

        player.actions:inviteToParty(member)
        member.actions:acceptPartyInvite()

        local strength = member:getMod(xi.mod.STR)
        enter()

        local content = xi.battlefield.contents[xi.battlefield.id.PROJECT_SHANTOTTOFICATION]
        local option  = bit.lshift(content.index, 4) + player:getBattlefield():getArea()
        member.entities:gotoAndTrigger('_4j0', { eventId = 32000, updates = { option } })
        xi.test.world:skipTime(2)

        for _, tablet in ipairs(tablets) do
            member.assert.no:hasKI(tablet)
        end

        member.assert:hasModifier(xi.mod.STR, strength + 150)
        member.assert:hasModifier(xi.mod.HPP, 200)
        member.assert:hasEffect(xi.effect.RERAISE)

        win()
        member.bcnm:expectWin()

        member.assert:hasKI(xi.keyItem.TONBERRY_KEY)
        member.assert:hasMission(xi.mission.log_id.ASA, xi.mission.id.asa.AN_UNEASY_PEACE)
    end)

    it('can be repeated after the mission', function()
        player:completeMission(xi.mission.log_id.ASA, xi.mission.id.asa.PROJECT_SHANTOTTOFICATION)
        player:addMission(xi.mission.log_id.ASA, xi.mission.id.asa.AN_UNEASY_PEACE)

        enter()
        win()

        player.assert:hasKI(xi.keyItem.TONBERRY_KEY)
        player.assert:hasMission(xi.mission.log_id.ASA, xi.mission.id.asa.AN_UNEASY_PEACE)
    end)

    it('has both sisters land every additional effect on a hit', function()
        -- Rules out a miss and a resist, so only the effect tables are under test.
        stub('xi.mobskills.processDamage', true)
        stub('xi.data.statusEffect.isTargetResistant', false)
        stub('xi.data.statusEffect.isResistRateSuccessfull', true)
        stub('xi.combat.magicHitRate.calculateResistRate', 1)
        enter()

        local shantotto  = player.entities:get(sacrificialChamberID.mob.SHANTOTTO + (player:getBattlefield():getArea() - 1) * 2)
        local dShantotto = player.entities:get(shantotto:getID() + 1)

        player:setPos(shantotto:getXPos() + 3, shantotto:getYPos(), shantotto:getZPos())
        shantotto:useMobAbility(xi.mobSkill.DIVINE_MALISON, player)
        waitForEffect(player, xi.effect.STUN)

        player.assert:hasEffect(xi.effect.STUN)
        player.assert:hasEffect(xi.effect.SILENCE)
        player.assert:hasEffect(xi.effect.PLAGUE)
        player.assert:hasEffect(xi.effect.DIA)

        player:setPos(dShantotto:getXPos() + 3, dShantotto:getYPos(), dShantotto:getZPos())
        dShantotto:useMobAbility(xi.mobSkill.SALVATION_SCYTHE, player)
        waitForEffect(player, xi.effect.POISON)

        player.assert:hasEffect(xi.effect.POISON)
        player.assert:hasEffect(xi.effect.PARALYSIS)
        player.assert:hasEffect(xi.effect.SLOW)
        player.assert:hasEffect(xi.effect.BIO)

        win()
    end)

    it('has Shantotto rage below 75%', function()
        enter()

        -- Each area holds one pair, Shantotto first.
        local shantotto = player.entities:get(sacrificialChamberID.mob.SHANTOTTO + (player:getBattlefield():getArea() - 1) * 2)
        local damage    = shantotto:getMod(xi.mod.DMG)
        -- updateEnmity only engages, and the hate entry needs the player in range.
        player:setPos(shantotto:getXPos() + 3, shantotto:getYPos(), shantotto:getZPos())
        shantotto:updateEnmity(player)
        shantotto:addEnmity(player, 1, 1)
        shantotto:setHP(math.floor(shantotto:getMaxHP() * 0.7))

        -- The rage waits for her to be free to act, so give her a few combat ticks.
        for _ = 1, 5 do
            xi.test.world:skipTime(2)
        end

        shantotto.assert:hasModifier(xi.mod.DMG, damage - 7000)

        win()
    end)
end)
