-----------------------------------
-- Trust: Amchuchu
-----------------------------------
---@type TSpellTrust
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return xi.trust.canCast(caster, spell)
end

spellObject.onSpellCast = function(caster, target, spell)
    return xi.trust.spawn(caster, spell)
end

spellObject.onMobSpawn = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.SPAWN)

    mob:addMod(xi.mod.INSPIRATION_FAST_CAST, 50)

    -----------------------------------
    -- Gambits
    -----------------------------------
    -- 1 condition
    mob:addGambit(ai.t.SELF,    { ai.c.NOT_HAS_TOP_ENMITY, 0                    }, { ai.r.JA, ai.s.SPECIFIC,        xi.ja.PROVOKE                })
    mob:addGambit(ai.t.TARGET,  { ai.c.CASTING_ELE_MA_AOE, 0                    }, { ai.r.MA, ai.s.SPECIFIC,        xi.ja.ONE_FOR_ALL            })
    mob:addGambit(ai.t.TARGET,  { ai.c.CASTING_ELE_MA_AOE, 0                    }, { ai.r.JA, ai.s.SPECIFIC,        xi.ja.VALIANCE               })
    mob:addGambit(ai.t.TARGET,  { ai.c.NOT_STATUS,         xi.effect.FLASH      }, { ai.r.MA, ai.s.SPECIFIC,        xi.magic.spell.FLASH         })
    mob:addGambit(ai.t.SELF,    { ai.c.NOT_STATUS,         xi.effect.PHALANX    }, { ai.r.MA, ai.s.SPECIFIC,        xi.magic.spell.PHALANX       })
    mob:addGambit(ai.t.SELF,    { ai.c.NO_MAX_RUNE,        0                    }, { ai.r.JA, ai.s.RUNE_DAY,        xi.ja.IGNIS                  })
    mob:addGambit(ai.t.SELF,    { ai.c.HPP_LT,             50                   }, { ai.r.JA, ai.s.SPECIFIC,        xi.ja.VIVACIOUS_PULSE        })
    mob:addGambit(ai.t.SELF,    { ai.c.NOT_STATUS,         xi.effect.SWORDPLAY  }, { ai.r.JA, ai.s.SPECIFIC,        xi.ja.SWORDPLAY              })
    mob:addGambit(ai.t.SELF,    { ai.c.NOT_STATUS,         xi.effect.FOIL       }, { ai.r.MA, ai.s.SPECIFIC,        xi.magic.spell.FOIL          })
    mob:addGambit(ai.t.SELF,    { ai.c.NOT_STATUS,         xi.effect.EMBOLDEN   }, { ai.r.JA, ai.s.SPECIFIC,        xi.ja.EMBOLDEN               })
    mob:addGambit(ai.t.SELF,    { ai.c.NOT_STATUS,         xi.effect.PROTECT    }, { ai.r.MA, ai.s.HIGHEST,         xi.magic.spellFamily.PROTECT })
    mob:addGambit(ai.t.SELF,    { ai.c.NOT_STATUS,         xi.effect.SHELL      }, { ai.r.MA, ai.s.HIGHEST,         xi.magic.spellFamily.SHELL   })
    mob:addGambit(ai.t.SELF,    { ai.c.NOT_STATUS,         xi.effect.BERSERK    }, { ai.r.JA, ai.s.SPECIFIC,        xi.ja.BERSERK                })
    mob:addGambit(ai.t.SELF,    { ai.c.HPP_LT,             75                   }, { ai.r.JA, ai.s.SPECIFIC,        xi.ja.BATTUTA                })
    mob:addGambit(ai.t.TARGET,  { ai.c.LUNGE_MB_AVAILABLE, 0                    }, { ai.r.JA, ai.s.SPECIFIC,        xi.ja.LUNGE                  })
    mob:addGambit(ai.t.TARGET,  { ai.c.LUNGE_MB_AVAILABLE, 0                    }, { ai.r.JA, ai.s.SPECIFIC,        xi.ja.SWIPE                  })
    mob:addGambit(ai.t.TARGET,  { ai.c.CAST_ELE_MA_SELF,   xi.effect.VALLATION  }, { ai.r.JA, ai.s.SPECIFIC,        xi.ja.VALLATION              })

    -- 2 conditions
    mob:addGambit(ai.t.TARGET,  { { ai.c.CAST_ELE_MA_SELF, 0                    }, { ai.c.NEED_ELE_BAREFFECT,  0 }, }, { ai.r.MA, ai.s.DEF_BAR_ELEMENT, 0                           })
    mob:addGambit(ai.t.SELF,    { { ai.c.NOT_STATUS,       xi.effect.REGEN      }, { ai.c.HPP_LT,             75 }, }, { ai.r.MA, ai.s.HIGHEST,         xi.magic.spellFamily.REGEN  })
    mob:addGambit(ai.t.SELF,    { { ai.c.NOT_STATUS,       xi.effect.REFRESH    }, { ai.c.MPP_LT,             75 }, }, { ai.r.MA, ai.s.SPECIFIC,        xi.magic.spell.REFRESH      })

    -- 3 conditions
    mob:addGambit(
        ai.t.SELF,
        { { ai.c.NOT_STATUS, xi.effect.STONESKIN  }, { ai.c.HPP_LT, 75 }, { ai.c.MPP_GTE, 50 }, },
        { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.STONESKIN }
    )

    mob:setTrustTPSkillSettings(ai.tp.CLOSER_UNTIL_TP, ai.s.HIGHEST, 3000)

    mob:addListener('WEAPONSKILL_USE', 'AMCHUCHU_WEAPONSKILL_USE', function(mobArg, target, wsid, tp, action)
        if wsid == 61 then -- Dimidation
            -- Nothing-wothing wrong with a little mad science now and again!
            xi.trust.message(mobArg, xi.trust.messageOffset.SPECIAL_MOVE_1)
        end
    end)
end

spellObject.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DESPAWN)
end

spellObject.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DEATH)
end

return spellObject
