class Quest2StudentService
  class << self
    # @return [String]
    def all_agents
      names = Agent.pluck(:codename).join("\n")
    end

    # @return [String]
    def all_missions
      missions = Mission.pluck(:title).sort.join("\n")
    end

    # @return [String]
    def agents_with_missions
      agents = Agent.includes(:missions)

      agents_missions = agents.map do |agent|
        missions = agent.missions.pluck(:title).join(", ")
        "#{agent.codename}: #{missions}"
      end.join("\n")
    end

    # @return [String]
    def agents_with_missions_sorted_by_mission_count
      agents = Agent.includes(:missions)

      agents_missions = agents.sort_by do |agent|
        [-agent.missions.count, agent.codename]
      end

      agents_missions.map do |agent|
        missions = agent.missions.pluck(:title).sort.join(", ")
        "#{agent.codename} (#{agent.missions.count}): #{missions}"
      end.join("\n")
    end

    # @return [String]
    def agents_with_skills
      agents = Agent.includes(:skills)

      agents_skills = agents.map do |agent|
        skills = agent.skills.pluck(:name).join(", ")
        "#{agent.codename}: #{skills}"
      end.join("\n")
    end

    # @return [String]
    def skills_by_agent_count
      skills = Skill.includes(:agents)

      skills_agent = skills.sort_by do |skill|
        [-skill.agents.count, skill.name]
      end

      skills_agent.map do |skill|
        agents = skill.agents.pluck(:codename).join(", ")
        "#{skill.name} (#{skill.agents.count}): #{agents}"
      end.join("\n")
    end
  end
end
