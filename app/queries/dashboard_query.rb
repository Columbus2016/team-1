class DashboardQuery
  def initialize(users_query)
    @users = User.where(id: users_query)
  end

  def by_cancer_type
    q = Cancer.joins(diagnoses: :user)
      .where(diagnoses: {user_id: @users})
    q.group("cancers.id")
      .select("COUNT(*) as count, cancers.name AS name")
      .to_a.map(&:attributes)
      .map{|attrs| [attrs["name"], attrs["count"]]}
  end

  def posts_by_month
    Shout.joins(:user)
      .where(user_id: @users)
      .group("date_trunc('month',shouts.created_at)")
      .select("date_trunc('month', shouts.created_at) as month,COUNT(*) as count")
      .to_a.map(&:attributes)
      .map{|a| [a["month"], a["count"]]}
  end

  QUERIES = %i(by_cancer_type posts_by_month)

  def to_h
    Hash[QUERIES.map{|q| [q, self.public_send(q)]}]
  end
end
