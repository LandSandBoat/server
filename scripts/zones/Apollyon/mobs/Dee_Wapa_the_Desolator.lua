-----------------------------------
-- Area: Apollyon CS
--  Mob: Dee Wapa the Desolator
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

local supportOffsets1 = { 3, 4, 5 }
local supportOffsets2 = { 6, 7, 8 }

entity.onMobFight = function(mob, target)
    local content = xi.battlefield.contents[xi.battlefield.id.CS_APOLLYON]
    content.handleBossCombatTick(mob, supportOffsets1, supportOffsets2)
end

entity.onMobEngage = function(mob, target)
    local content = xi.battlefield.contents[xi.battlefield.id.CS_APOLLYON]
    content.handleBossAutoAggro(mob, target)
end

return entity
