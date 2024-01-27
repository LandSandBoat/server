-----------------------------------
-- ID: 17566
-- Treat Staff
-- Latent effect during Harvest Festival events
--
-- This effect is triggered similar to an Additional Effect when attacking monsters.
-- when the effect activates, you will be Warped to your Home Point.
-- This allegedly can trigger on missed attacks and Weapon Skills. TODO: confirm
-- There is no animation present when this effect activates, you will simply disappear and reappear at your Home Point.
-- According to https://wiki.ffo.jp/html/3736.html the effect is
-- only moon phase based when the Harvest Festival event is NOT active but ...
-- Hours were spent attempting to trigger a proc during the moon conditions describe to no avail.
-- (it wasn't changed, seems that information was simply incorrect)
--
-- Calling it 10% proc rate, this is tough to get a decent sample for even during harvest fest event.
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemEquip  = function(user, item)
    user:addListener('ATTACK', 'TREAT_STAFF_MELEE', function(player, target, action)
        if
            math.random(1, 100) <= 10 and
            xi.events.harvestFestival.isHalloweenEnabled()
        then
            -- Need a small delay for the swing animation.
            player:timer(100, function(playerArg)
                -- We normally NEVER do this, but we want to skip animating the warp itself.
                playerArg:warp()
            end)
        end
    end)
end

itemObject.onItemUnequip = function(user, item)
    user:removeListener('TREAT_STAFF_MELEE')
    -- user:removeListener('TREAT_STAFF_WS')
    -- user:removeListener('TREAT_STAFF_MISSED')
end

return itemObject
