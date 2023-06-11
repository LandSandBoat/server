require("scripts/globals/mixins")
require("scripts/globals/utils")

g_mixins = g_mixins or {}

g_mixins.fomor_hate = function(fomorMob)
    fomorMob:addListener("DEATH", "FOMOR_HATE_DEATH", function(mob, player)
        if player then
            local alliance = player:getAlliance()
            for _, member in pairs(alliance) do
                if member:getZoneID() == player:getZoneID() then
                    local hate = member:getCharVar("FOMOR_HATE")
                    local adj = mob:getLocalVar("fomorHateAdj")
                    if adj == 0 then
                        adj = 2 -- default: most fomor add 2 hate
                    end

                    -- if not a fomor then decrease hate instead of increase
                    -- Note cannot use negatives in fomorHateAdj because local vars can only be positive
                    if mob:getFamily() ~= 115 and mob:getFamily() ~= 359 then
                        adj = -adj
                    end

                    member:setCharVar("FOMOR_HATE", utils.clamp(hate + adj, 0, 60))
                end
            end
        end
    end)
end

return g_mixins.fomor_hate
