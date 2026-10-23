local lilies = require('scripts/events/harvest_festival_lilies')

describe('Harvest Festival: Wake of the Lilies', function()
    local ID = zones[xi.zone.NORTHERN_SAN_DORIA]
    local player
    local npcs
    local zone
    local now
    local enabled

    before_each(function()
        xi.test.world:setSetting('main.HALLOWEEN_YEAR', 2007)
        enabled = true
        now = 1000
        player =
        {
            vars = {},
            charVars = {},
            items = {},
            messages = {},
            costume = false,
            head = 0,
            distance = 8,
            inFront = false,
            freeSlots = 1,
        }

        function player:getLocalVar(name)
            return self.vars[name] or 0
        end

        function player:setLocalVar(name, value)
            self.vars[name] = value
        end

        function player:getCharVar(name)
            return self.charVars[name] or 0
        end

        function player:setCharVar(name, value)
            self.charVars[name] = value
        end

        function player:getZoneID()
            return xi.zone.NORTHERN_SAN_DORIA
        end

        function player:getEquipID()
            return self.head
        end

        function player:hasItem(itemId)
            return (self.items[itemId] or 0) > 0
        end

        function player:startEvent(eventId, parameter1, parameter2)
            self.event = { eventId, parameter1, parameter2 }
        end

        function player:isInEvent()
            return false
        end

        function player:messageSpecial(textId)
            table.insert(self.messages, textId)
        end

        function player:hasStatusEffect(effect)
            assert(effect == xi.effect.COSTUME)
            return self.costume
        end

        function player:getStatusEffect(effect)
            assert(effect == xi.effect.COSTUME)
            if not self.costume then
                return nil
            end

            return
            {
                getPower = function()
                    return 368
                end,
            }
        end

        function player:delStatusEffect(effect)
            assert(effect == xi.effect.COSTUME)
            self.costume = false
        end

        zone = {}

        function zone:getID()
            return xi.zone.NORTHERN_SAN_DORIA
        end

        function zone:getPlayers()
            return { player }
        end

        npcs = {}
        for _, npcId in ipairs({ ID.npc.HARVEST_LILIES_EXORCIST, unpack(ID.npc.HARVEST_LILIES_WITCHES) }) do
            local npc = { vars = {}, id = npcId, rotation = 0 }

            function npc:getID()
                return self.id
            end

            function npc:getZoneID()
                return xi.zone.NORTHERN_SAN_DORIA
            end

            function npc:getZone()
                return zone
            end

            function npc:getLocalVar(name)
                return self.vars[name] or 0
            end

            function npc:setLocalVar(name, value)
                self.vars[name] = value
            end

            function npc:initNpcAi()
                self.listener = nil
            end

            function npc:setStatus(status)
                self.status = status
            end

            function npc:getStatus()
                return self.status
            end

            function npc:addListener(event, name, listener)
                assert(event == 'TICK' and name == 'HARVEST_LILIES')
                self.listener = listener
            end

            function npc:removeListener(name)
                assert(name == 'HARVEST_LILIES')
                self.listener = nil
            end

            function npc:pathTo(x, y, z, flags)
                assert(flags == xi.pathflag.SCRIPT)
                self.path = { x, y, z }
            end

            function npc:clearPath()
                self.path = nil
            end

            function npc:isFollowingPath()
                return self.path ~= nil
            end

            function npc:getRotPos()
                return self.rotation
            end

            function npc:setRotation(rotation)
                self.rotation = rotation
            end

            function npc:checkDistance(target)
                return target.distance
            end

            function npc:isFacing(target)
                return target.inFront
            end

            function npc:canSee(target)
                return not target.obstructed
            end

            npcs[npcId] = npc
        end

        stub('GetSystemTime', function()
            return now
        end)

        stub('getVanaMidnight', 1300)

        stub('GetNPCByID', function(npcId)
            return npcs[npcId]
        end)

        stub('xi.events.harvestFestival.isEnabled', function()
            return enabled
        end)

        stub('npcUtil.giveItem', function(target, items)
            if target.freeSlots == 0 then
                return false
            end

            target.items[items[1][1]] = (target.items[items[1][1]] or 0) + items[1][2]
            return true
        end)

        lilies.initializeZone(zone)
    end)

    it('uses native NQ acceptance and permits cancellation without a wait', function()
        lilies.onExorcistTrigger(player)
        assert(player.event[1] == 32728)
        lilies.onExorcistEventFinish(player, 32728, 0)
        assert(player:getLocalVar('HarvestLiliesTarget') == 0)
        lilies.onExorcistTrigger(player)
        lilies.onExorcistEventFinish(player, 32728, 1)
        assert(player:getLocalVar('HarvestLiliesTarget') == ID.npc.HARVEST_LILIES_WITCHES[1])
        lilies.onExorcistTrigger(player)
        assert(player.event[1] == 32730)
        lilies.onExorcistEventFinish(player, 32730, 1)
        assert(player:getLocalVar('HarvestLiliesTarget') == 0)
        assert(player:getCharVar('[HarvestFestival]LiliesWait') == 0)
    end)

    it('requires removing a costume before speaking to the exorcist', function()
        player.costume = true
        lilies.onExorcistTrigger(player)
        assert(not player.event)
        assert(player:getLocalVar('HarvestLiliesEvent') == 0)
        player:delStatusEffect(xi.effect.COSTUME)
        lilies.onExorcistTrigger(player)
        assert(player.event[1] == 32728)
    end)

    it('makes the HQ witch scan faster and detect farther without seeing through walls', function()
        player.head = xi.item.WITCH_HAT
        lilies.onExorcistTrigger(player)
        lilies.onExorcistEventFinish(player, 32731, 1)
        player.costume = true
        player.inFront = true
        player.obstructed = true
        player.distance = 8
        local witch = npcs[ID.npc.HARVEST_LILIES_WITCHES[2]]
        witch:clearPath()
        lilies.onWitchTick(witch)
        assert(witch.rotation == 32)
        assert(player.costume)
        now = now + 1
        player.obstructed = false
        lilies.onWitchTick(witch)
        assert(not player.costume)
        witch:setLocalVar('HarvestLiliesTurn', 8)
        now = now + 1
        lilies.onWitchTick(witch)
        assert(witch.rotation == 32, 'HQ scanning should reverse direction')
    end)

    it('assigns the HQ witch from the hat worn at acceptance', function()
        player.head = xi.item.WITCH_HAT
        lilies.onExorcistTrigger(player)
        assert(player.event[1] == 32731)
        lilies.onExorcistEventFinish(player, 32731, 1)
        player.head = 0
        assert(player:getLocalVar('HarvestLiliesTarget') == ID.npc.HARVEST_LILIES_WITCHES[2])
    end)

    it('requires the assigned witch and preserves heard stages after detection', function()
        lilies.onExorcistTrigger(player)
        lilies.onExorcistEventFinish(player, 32728, 1)
        player.costume = true
        lilies.onWitchTick(npcs[ID.npc.HARVEST_LILIES_WITCHES[2]])
        assert(#player.messages == 0)
        local witch = npcs[ID.npc.HARVEST_LILIES_WITCHES[1]]
        lilies.onWitchTick(witch)
        assert(player.messages[1] == ID.text.HARVEST_LILIES_JOINED)
        now = 1008
        lilies.onWitchTick(witch)
        assert(player:getLocalVar('HarvestLiliesProgress') == 1)
        player.inFront = true
        player.distance = 4
        now = 1009
        lilies.onWitchTick(witch)
        assert(not player.costume)
        assert(player.messages[3] == ID.text.HARVEST_LILIES_DETECTED)
        assert(player:getLocalVar('HarvestLiliesProgress') == 1)
        player.costume = true
        player.inFront = false
        now = 1010
        lilies.onWitchTick(witch)
        now = 1018
        lilies.onWitchTick(witch)
        assert(player:getLocalVar('HarvestLiliesProgress') == 2)
    end)

    it('completes ten stages and retains a full-bag claim until a successful reward', function()
        lilies.onExorcistTrigger(player)
        lilies.onExorcistEventFinish(player, 32728, 1)
        player.costume = true
        local witch = npcs[ID.npc.HARVEST_LILIES_WITCHES[1]]
        lilies.onWitchTick(witch)
        for _ = 1, 10 do
            now = now + 8
            lilies.onWitchTick(witch)
        end

        assert(player.messages[11] == ID.text.HARVEST_LILIES_PROGRESS + 9)
        player:delStatusEffect(xi.effect.COSTUME)
        lilies.onExorcistTrigger(player)
        assert(player.event[1] == 32729 and player.event[3] == 0)
        player.freeSlots = 0
        lilies.onExorcistEventFinish(player, 32729, 0)
        assert(player:getLocalVar('HarvestLiliesProgress') == 10)
        assert(player:getCharVar('[HarvestFestival]LiliesWait') == 0)
        player.freeSlots = 1
        lilies.onExorcistTrigger(player)
        lilies.onExorcistEventFinish(player, 32729, 0)
        assert(player:hasItem(xi.item.WITCH_HAT))
        assert(player:getLocalVar('HarvestLiliesTarget') == 0)
        lilies.onExorcistTrigger(player)
        assert(player.event[1] == 32732)
    end)

    it('expires an unfinished request at Vana midnight', function()
        lilies.onExorcistTrigger(player)
        lilies.onExorcistEventFinish(player, 32728, 1)
        now = 1300
        lilies.onWitchTick(npcs[ID.npc.HARVEST_LILIES_WITCHES[1]])
        assert(player:getLocalVar('HarvestLiliesTarget') == 0)
        lilies.onExorcistTrigger(player)
        assert(player.event[1] == 32728)
    end)

    it('grants the HQ hat and twelve, eleven, then ten fireworks on repeats', function()
        player.head = xi.item.WITCH_HAT
        player.items[xi.item.WITCH_HAT] = 1
        for _, quantity in ipairs({ 0, 12, 11, 10, 10 }) do
            player:setCharVar('[HarvestFestival]LiliesWait', 0)
            lilies.onExorcistTrigger(player)
            lilies.onExorcistEventFinish(player, 32731, 1)
            player:setLocalVar('HarvestLiliesProgress', 10)
            lilies.onExorcistTrigger(player)
            assert(player.event[3] == 1)
            local previous = player.items[xi.item.PAPILLION] or 0
            lilies.onExorcistEventFinish(player, 32729, 0)
            assert(player:hasItem(xi.item.COVEN_HAT))
            assert((player.items[xi.item.PAPILLION] or 0) - previous == quantity)
        end
    end)

    it('awards fireworks for a duplicate easy hat without preventing the later HQ reward', function()
        player.items[xi.item.WITCH_HAT] = 1
        lilies.onExorcistTrigger(player)
        lilies.onExorcistEventFinish(player, 32728, 1)
        player:setLocalVar('HarvestLiliesProgress', 10)
        lilies.onExorcistTrigger(player)
        assert(player.event[1] == 32729 and player.event[3] == 1)
        lilies.onExorcistEventFinish(player, 32729, 0)
        assert(player.items[xi.item.PAPILLION] == 12)
        assert(not player:hasItem(xi.item.COVEN_HAT))

        player:setCharVar('[HarvestFestival]LiliesWait', 0)
        player.head = xi.item.WITCH_HAT
        lilies.onExorcistTrigger(player)
        lilies.onExorcistEventFinish(player, 32731, 1)
        player:setLocalVar('HarvestLiliesProgress', 10)
        lilies.onExorcistTrigger(player)
        lilies.onExorcistEventFinish(player, 32729, 0)
        assert(player:hasItem(xi.item.COVEN_HAT))
        assert(player.items[xi.item.PAPILLION] == 12)
    end)

    it('blocks stale event replies when disabled or switched to 2005', function()
        lilies.onExorcistTrigger(player)
        enabled = false
        lilies.onExorcistEventFinish(player, 32728, 1)
        assert(player:getLocalVar('HarvestLiliesTarget') == 0)
        enabled = true
        xi.test.world:setSetting('main.HALLOWEEN_YEAR', 2005)
        lilies.onExorcistEventFinish(player, 32728, 1)
        assert(player:getLocalVar('HarvestLiliesTarget') == 0)
    end)

    it('cleans up listeners, routes, actors and player requests', function()
        lilies.onExorcistTrigger(player)
        lilies.onExorcistEventFinish(player, 32728, 1)
        lilies.cleanupZone(zone)
        assert(player:getLocalVar('HarvestLiliesTarget') == 0)
        for _, npc in pairs(npcs) do
            assert(npc.status == xi.status.DISAPPEAR)
            assert(not npc.listener and not npc.path)
        end
    end)
end)

describe('Harvest Festival: native Lilies events', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        xi.test.world:setSetting('main.HALLOWEEN_YEAR', 0)
        xi.test.world:setSetting('main.HALLOWEEN_YEAR_ROUND', 1)
        xi.events.harvestFestival.update()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.NORTHERN_SAN_DORIA })
        if player:isInEvent() then
            player.events:finish()
        end

        xi.test.world:setSetting('main.HALLOWEEN_YEAR', 2007)
        xi.events.harvestFestival.update()
    end)

    after_each(function()
        xi.test.world:setSetting('main.HALLOWEEN_YEAR', 0)
        xi.events.harvestFestival.update()
    end)

    it('accepts the native request, follows the assigned witch, and reports for a hat', function()
        xi.test.world:setVanaTime(12, 0)
        local now = GetSystemTime()
        stub('GetSystemTime', function()
            return now
        end)

        player.entities:gotoAndTrigger('Gertrude', { eventId = 32728, finishOption = 1 })
        local witchId = zones[xi.zone.NORTHERN_SAN_DORIA].npc.HARVEST_LILIES_WITCHES[1]
        assert(player:getLocalVar('HarvestLiliesTarget') == witchId)
        local witch = GetNPCByID(witchId)
        assert(witch)
        player:addStatusEffect(xi.effect.COSTUME, { power = 368, duration = 3600, origin = player })
        witch:setLocalVar('HarvestLiliesNextTick', 0)
        local position = witch:getPos()
        player:setPos(position.x + 8, position.y, position.z)
        lilies.onWitchTick(witch)
        for _ = 1, 10 do
            now = now + 8
            position = witch:getPos()
            player:setPos(position.x + 8, position.y, position.z)
            lilies.onWitchTick(witch)
        end

        assert(player:getLocalVar('HarvestLiliesProgress') == 10)
        player:delStatusEffect(xi.effect.COSTUME)
        player.entities:gotoAndTrigger('Gertrude', { eventId = 32729, finishOption = 0 })
        player.assert:hasItem(xi.item.WITCH_HAT)
        assert(player:getLocalVar('HarvestLiliesTarget') == 0)
        player.entities:gotoAndTrigger('Gertrude', { eventId = 32732, finishOption = 0 })
    end)

    it('discards the request and progress when the player changes zones', function()
        player.entities:gotoAndTrigger('Gertrude', { eventId = 32728, finishOption = 1 })
        player:setLocalVar('HarvestLiliesProgress', 4)
        player:gotoZone(xi.zone.SOUTHERN_SAN_DORIA)
        assert(player:getLocalVar('HarvestLiliesTarget') == 0)
        assert(player:getLocalVar('HarvestLiliesProgress') == 0)
    end)
end)
