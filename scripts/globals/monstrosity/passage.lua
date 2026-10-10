-----------------------------------
-- Monstrosity - Odyssean Passage (Feretory)
-----------------------------------
xi = xi or {}
xi.monstrosity = xi.monstrosity or {}

-- The client builds the zone list from the zones the character has visited, and backs out of a
-- category with none.
xi.monstrosity.odysseanPassageOnTrigger = function(player, npc)
    if xi.settings.main.ENABLE_MONSTROSITY ~= 1 then
        return
    end

    local restricted = player:getBelligerencyFlag() and 1 or 0
    player:startEvent(5, 0, player:getMonstrositySize(), restricted)
end

-- Picking a zone asks for its Belligerency level cap, 0 for none.
xi.monstrosity.odysseanPassageOnEventUpdate = function(player, csid, option, npc)
    if csid ~= 5 then
        return
    end

    local zoneSelected = bit.band(bit.rshift(option, 4), 0xFFF)
    player:updateEvent(xi.monstrosity.belligerencyCaps[zoneSelected] or 0)
end

-- Bits 0-3 are the choice, 4-15 the zone, 0 to stop being a Monipulator.
xi.monstrosity.odysseanPassageOnEventFinish = function(player, csid, option, npc)
    if
        csid ~= 5 or
        bit.band(option, 0xF) ~= 1
    then
        return
    end

    local zoneSelected = bit.band(bit.rshift(option, 4), 0xFFF)
    if zoneSelected == 0 then
        xi.monstrosity.onMonstrosityReturnToEntrance(player)
        return
    end

    -- The client only offers visited field and dungeon zones, and Belligerency zones while it is on.
    if
        not player:isMonstrosityPassageZone(zoneSelected) or
        not player:hasVisitedZone(zoneSelected) or
        (player:getBelligerencyFlag() and not xi.monstrosity.belligerencyCaps[zoneSelected])
    then
        return
    end

    -- TODO: Capture the exits for every zone. Until then a zone script places an arrival at (0, 0, 0) on its default entry point.
    local exits = player:getMonstrosityExits(zoneSelected)
    if #exits == 0 then
        player:setPos(0, 0, 0, 0, zoneSelected)
        return
    end

    local exit = utils.randomEntry(exits)
    player:setPos(exit[1], exit[2], exit[3], exit[4], zoneSelected)
end
