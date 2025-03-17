-----------------------------------
-- Einherjar: Chamber reservation
-----------------------------------
xi = xi or {}
xi.einherjar = xi.einherjar or {}

xi.einherjar.meetsRequirementsForReservation = function(player)
    local texts = zones[xi.zone.HAZHALM_TESTING_GROUNDS].text
    local lockout = xi.einherjar.isLockedOut(player)
    local toau = player:hasCompletedMission(xi.mission.log_id.TOAU, xi.mission.id.toau.IMMORTAL_SENTRIES)

    -- 1. Player must be level EINHERJAR_LEVEL_MIN+
    if player:getMainLvl() < xi.einherjar.settings.EINHERJAR_LEVEL_MIN then
        player:messageSpecial(texts.MIN_LEVEL_RESERVATION, xi.einherjar.settings.EINHERJAR_LEVEL_MIN)
        return false
    end

    -- 2. Must have ToAU mission 2 completed
    if not toau then
        player:messageSpecial(texts.REQUIREMENTS_UNMET)
        return false
    end

    -- 3. Player must not be locked out
    if lockout ~= 0 then
        player:messageSpecial(texts.RESERVATION_LOCKOUT, lockout)
        return false
    end

    return true
end

xi.einherjar.meetsRequirementsForEntry = function(player, chamberId)
    local texts = zones[xi.zone.HAZHALM_TESTING_GROUNDS].text
    local lockout = xi.einherjar.isLockedOut(player)
    local toau = player:hasCompletedMission(xi.mission.log_id.TOAU, xi.mission.id.toau.IMMORTAL_SENTRIES)
    local chamberData = xi.einherjar.getChamber(chamberId)

    if not chamberData then
        player:messageSpecial(texts.REQUIREMENTS_UNMET)
        return false
    end

    -- 1. Player must be level EINHERJAR_LEVEL_MIN+
    if player:getMainLvl() < xi.einherjar.settings.EINHERJAR_LEVEL_MIN then
        player:messageSpecial(texts.MIN_LEVEL_ENTRY, xi.einherjar.settings.EINHERJAR_LEVEL_MIN)
        return false
    end

    -- 2. Must have ToAU mission 2 completed
    if not toau then
        player:messageSpecial(texts.REQUIREMENTS_UNMET)
        return false
    end

    -- 3. Player must not be locked out
    if lockout ~= 0 then
        player:messageSpecial(texts.ENTRY_PROHIBITED, lockout)
        return false
    end

    -- 5. The leader must have entered the chamber
    if
        not chamberData.players[chamberData.leaderId] and
        player:getID() ~= chamberData.leaderId
    then
        player:messageSpecial(texts.GROUP_LEADER_NOT_YET_ENTERED)
        return false
    end

    -- 6. Max players limit
    local count = 0
    for _ in pairs(chamberData.players) do
        count = count + 1
    end

    if count >= xi.einherjar.settings.EINHERJAR_MAX_PLAYERS_PER_CHAMBER then
        player:messageSpecial(texts.CHAMBER_FULL)
        return false
    end

    if chamberData.locked then
        player:messageSpecial(texts.MEMBERS_ENGAGED_IN_BATTLE)
        return false
    end

    return true
end
