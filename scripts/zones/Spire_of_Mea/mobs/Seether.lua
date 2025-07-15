-----------------------------------
-- Area: Spire of Mea
--  Mob: Seether ("Pet" of Envier)
-----------------------------------
mixins = { require('scripts/mixins/families/empty_terroanima') }
-----------------------------------
---@type TMobEntity
local entity = {}

-- TODO: Perform full captures on Seether.

local vars =
{
    TP_DELAY = 'tpDelay',
}

-----------------------------------
-- Add a short TP delay so that the preparation message shows in the chat.
-----------------------------------
entity.onMobSpawn = function(mob)
    mob:setLocalVar(vars.TP_DELAY, GetSystemTime() + 1)
end

-----------------------------------
-- Use initial TP move after TP delay is over.
-----------------------------------
entity.onMobFight = function(mob, target)
    local tpDelay = mob:getLocalVar(vars.TP_DELAY)

    if
        tpDelay > 0 and
        tpDelay < GetSystemTime()
    then
        mob:setTP(3000)
        mob:setLocalVar(vars.TP_DELAY, 0)
    end
end

return entity
