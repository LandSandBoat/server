#ifndef _SPIRITCONTROLLER_H
#define _SPIRITCONTROLLER_H

#include "../../entities/petentity.h"
#include "../../spell.h"
#include "../../status_effect.h"
#include "pet_controller.h"
#include <optional>

struct PMemberTargets
{
    CBattleEntity* PLowest;
    CBattleEntity* PNearest;
};
class CSpiritController;

class CSpiritController : public CPetController
{
public:
    CSpiritController(CPetEntity* PPet);

    static constexpr float PetRoamDistance{ 2.1f };
    virtual void           DoRoamTick(time_point tick) override
    {
    }
    virtual void DoCombatTick(time_point tick) override
    {
    }
    // We need to be able to reset the Magic cooldown on link, and Assault/Retreat.
    virtual void setMagicCooldowns();

protected:
    uint8        lastChoice;
    virtual void Tick(time_point tick) override;
    virtual void LoadLightSpiritSpellList();
    virtual void HandleEnmity() override
    {
    }
    virtual void TryLink() override
    {
    }

    bool           TrySpellcast(time_point tick);
    bool           TryIdleSpellcast(time_point tick);
    int16          GetSMNSkillReduction();
    int16          GetDayWeatherBonus();
    PMemberTargets GetBestQualifiedMembers();
    uint8          GetLowestHPThresholdCountForParty(CBattleEntity& target);
    uint16         DetermineHighestSpellFromMP(std::vector<uint16>& spellList);
    bool           CastIdleSpell(SpellID spellId, uint16 target);
    uint16         DetermineNextBuff(CBattleEntity& target);

private:
    CPetEntity* const PSpirit;
};

#endif
