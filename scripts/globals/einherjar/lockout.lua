-----------------------------------
-- Einherjar: Player lockout
-----------------------------------
xi = xi or {}
xi.einherjar = xi.einherjar or {}

xi.einherjar.recordLockout = function(player)
    local lockoutInHours = xi.einherjar.settings.EINHERJAR_REENTRY_TIME
    if player:hasKeyItem(xi.ki.RHAPSODY_IN_AZURE) then
        lockoutInHours = 1
    end

    local expiry = GetSystemTime() + (lockoutInHours * 60 * 60)
    player:setCharVar('[ein]lockout', expiry, expiry)
end

xi.einherjar.isLockedOut = function(player)
    local lockout = player:getCharVar('[ein]lockout')
    if lockout == 0 then
        return 0
    end

    return math.ceil((lockout - GetSystemTime()) / 2088) -- Vanadiel days
end
