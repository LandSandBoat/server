-----------------------------------
-- Area: Temple of Uggalepih
--   NM: Rompaulion S Citalle
-- Involved with San d'Oria quest "Knight Stalker"
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- check for Cleuvarion death
    if
        player:getCharVar('KnightStalker_Progress') == 4 and
        GetMobByID(mob:getID() - 1):isDead()
    then
        player:setCharVar('KnightStalker_Kill', 1)
    end
end

return entity
