require('scripts/globals/mixins')

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.tonberry = function(tonberryMob)
    tonberryMob:addListener('DEATH', 'TONBERRY_DEATH', function(mob, player)
        if player then
            local alliance = player:getAlliance()
            for _, member in pairs(alliance) do
                if member:getZoneID() == player:getZoneID() then
                    local kills = member:getCharVar('EVERYONES_GRUDGE_KILLS')
                    if kills < 480 then
                        member:setCharVar('EVERYONES_GRUDGE_KILLS', kills + 1)
                    end
                end
            end
        end
    end)
end

return g_mixins.families.tonberry
