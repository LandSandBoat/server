require('scripts/globals/mixins')
require('scripts/globals/utils')

g_mixins = g_mixins or {}

g_mixins.fomor_hate = function(fomorMob)
    fomorMob:addListener('DEATH', 'FOMOR_HATE_DEATH', function(mob, player)
        if player then
            local alliance = player:getAlliance()
            for _, member in pairs(alliance) do
                if member:getZoneID() == player:getZoneID() then
                    local hate = member:getCharVar('FOMOR_HATE')
                    local adj = mob:getLocalVar('fomorHateAdj')
                    if adj == 0 then
                        adj = 2 -- default: most fomor add 2 hate
                    end

                    member:setCharVar('FOMOR_HATE', utils.clamp(hate + adj, 0, 60))
                end
            end
        end
    end)
end

return g_mixins.fomor_hate
