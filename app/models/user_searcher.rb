class UserSearcher
  attr_reader :where_clause, :where_args, :exclude_clause, :exclude_args, :order
  def initialize(search_term, searcher_id)
    search_term = search_term.downcase

    @where_clause = ''
    @exclude_clause = ''
    @where_args = {}

    build_for_name_search(search_term, searcher_id)
  end

  private

  def build_for_name_search(search_term, searcher_id)
    @where_clause << case_insensitive_search(:first_name)
    @where_args[:first_name] = composed_with(search_term)

    @where_clause << " OR #{case_insensitive_search(:last_name)}"
    @where_args[:last_name] = composed_with(search_term)

    @exclude_clause << " #{:id} <> #{searcher_id} "
    @exclude_args[:id] = "#{searcher_id}"

    @order = 'last_name asc'
  end

  def composed_with(search_term)
    "%#{search_term}%"
  end

  def case_insensitive_search(field_name)
    "lower(#{field_name}) like :#{field_name}"
  end
end