require "rails_helper"

def inverse_reflection_klass(reflection)
	case reflection
	when ActiveRecord::Reflection::ThroughReflection   then [ActiveRecord::Reflection::ThroughReflection]
	when ActiveRecord::Reflection::HasOneReflection    then [ActiveRecord::Reflection::BelongsToReflection]
	when ActiveRecord::Reflection::HasManyReflection   then [ActiveRecord::Reflection::BelongsToReflection]
	when ActiveRecord::Reflection::BelongsToReflection then [ActiveRecord::Reflection::HasManyReflection, ActiveRecord::Reflection::HasOneReflection]
	else fail TypeError, "inverse reflection for #{reflection.class} is not established"
	end
end


def reflection_containing_class(reflection)
	if reflection.respond_to?(:active_record)
		reflection.active_record
	else
		# reflection.klass
		"?"
	end
end

def reflection_containing_class_table_name(reflection)
	# if reflection.respond_to?(:active_record)
	# 	reflection.table_name
	# else
	# 	reflection.table_name
	# end
	"?"
end


def inspect_all_reflections(reflection, pad)
	puts
	puts "#{pad} Checking name on through_reflection works unstable"
	reflection.chain.each_with_index do |inner_refl, index|
		puts    pad
		puts    pad
		puts "#{pad} <Chain entry #{index + 1}>"
		inspect_reflection(inner_refl, index, pad + "  ")
		puts "#{pad} </Chain entry #{index + 1}>"
	end

	if reflection.inverse_of
		puts    pad
		puts    pad
		puts "#{pad} <Inverse>"
		inspect_reflection(reflection.inverse_of, 0, pad + "  ")
		puts "#{pad} </Inverse>"
	end

	puts    pad
	puts    pad
	puts "#{pad} Right class:"
	puts    pad
	puts "#{pad}   class #{reflection.class_name} # table: #{reflection.table_name}"
	puts    pad
	puts "#{pad}   end"
	puts    pad
	puts "#{pad}   klass         => #{reflection.klass.name}"
	puts "#{pad}   class_name    => #{reflection.class_name}"
	puts "#{pad}   table_name    => #{reflection.table_name}"

	# binding.pry unless reflection.name == inverse_name
end


def reflection_macro_with_options(reflection, index, pad)
	if index.zero?
		puts "#{pad}   #{reflection.macro if reflection.respond_to?(:macro)} :#{reflection.name},"
		puts "#{pad}           #{reflection.options}" if reflection.respond_to?(:options)
		puts "#{pad}           #{reflection.through_options}" if reflection.respond_to?(:through_options)
		puts "#{pad}           #{reflection.source_options}" if reflection.respond_to?(:source_options) if reflection.through_reflection?
	else
		puts "#{pad}   ?"
	end
end


def inspect_reflection(reflection, index, pad)
	# binding.pry if reflection.is_a?(ActiveRecord::Reflection::PolymorphicReflection)

	not_polymorphic = (reflection.respond_to?("polymorphic?") && !reflection.polymorphic?)

	puts "#{pad} class #{reflection_containing_class(reflection)} # table: #{reflection_containing_class_table_name(reflection)}"
									reflection_macro_with_options(reflection, index, pad)
	puts "#{pad} end"
	puts    pad
	puts "#{pad} reflection class          => #{reflection}"
	puts "#{pad} association_class         => #{reflection.association_class}" if reflection.respond_to?(:association_class)
	puts "#{pad} type                      => #{reflection.type}"
	puts "#{pad} macro                     => #{reflection.macro}" if reflection.respond_to?(:macro)
	puts "#{pad} active_record (base)      => #{reflection.active_record}" if reflection.respond_to?(:active_record) && index.zero?
# puts "#{pad} class_name                => #{reflection.class_name}" if reflection.respond_to?(:class_name)
	puts "#{pad} name                      => #{reflection.name}" if reflection.respond_to?(:name)
	puts "#{pad} klass                     => #{reflection.klass}" if not_polymorphic
	puts "#{pad} plural_name               => #{reflection.plural_name}" if reflection.respond_to?(:plural_name)
	puts "#{pad} table_name (base?)        => #{reflection.table_name}" if reflection.respond_to?(:table_name) && not_polymorphic
	puts "#{pad} active_record_primary_key => #{reflection.active_record_primary_key}" if reflection.respond_to?(:active_record_primary_key)
	puts "#{pad} association_primary_key   => #{reflection.association_primary_key}" if reflection.respond_to?(:association_primary_key) && not_polymorphic
	puts "#{pad} association_foreign_key   => #{reflection.association_foreign_key}" if reflection.respond_to?(:association_foreign_key)
	puts "#{pad} foreign_key               => #{reflection.foreign_key}" if reflection.respond_to?(:foreign_key)
	puts "#{pad} foreign_type              => #{reflection.foreign_type}" if reflection.respond_to?(:foreign_type)
	puts "#{pad} join_foreign_key          => #{reflection.join_foreign_key}" if reflection.respond_to?(:join_foreign_key)
	puts "#{pad} join_primary_key          => #{reflection.join_primary_key}" if reflection.respond_to?(:join_primary_key) && not_polymorphic
	puts "#{pad} join_keys                 => #{reflection.join_keys}" if reflection.respond_to?(:join_keys)
	puts "#{pad} through_reflection?       => #{reflection.through_reflection?}"
	puts "#{pad} polymorphic?              => #{reflection.polymorphic?}" if reflection.respond_to? "polymorphic?"
	puts "#{pad} has_one?                  => #{reflection.has_one?}" if reflection.respond_to? "has_one?"
	puts "#{pad} through_reflection        => #{reflection.through_reflection}" if reflection.respond_to?(:through_reflection)
	puts "#{pad} parent_reflection         => #{reflection.parent_reflection}" if reflection.respond_to?(:parent_reflection)
	puts "#{pad} actual_source_reflection  => #{reflection.actual_source_reflection}" if reflection.respond_to?(:actual_source_reflection)
end

shared_examples "is a valid reflection" do
	it { is_expected.to be_constructable }

	it "is expected to pass validity check" do
		# expect { subject.check_validity! }.not_to raise_exception
		subject.check_validity!
	rescue => error
		puts error.message
		raise error
	end

	it "is expected to be eager_loadable" do
		expect { subject.check_eager_loadable! }.not_to raise_exception
	end

	it "is expected to be preloadable" do
		expect { subject.check_preloadable! }.not_to raise_exception
	end

	# Cannot have a has_many :through asso...' without 'source_type'
	it "is expected to have :source_type" do
		# if reflection.has_many_through?
		# end
	end

end

shared_examples "has correct inverse" do
	it { is_expected.to have_inverse }

	it "is expected to pass validity_of_inverse check" do
		expect { subject.check_validity_of_inverse! }.not_to raise_exception
	end
end

shared_examples "has correct inverse wip" do

	it "is expected to have an `inverse_of` of correct class" do
		fail "is expected to have inverse_of" unless subject.has_inverse?
		fail "is expected to have inverse_of" unless subject.inverse_of
		# if subject.has_inverse? && subject.inverse_of
			# begin
				expect(subject.inverse_of.class).to be_in inverse_reflection_klass(subject)
			# rescue ActiveRecord::InverseOfAssociationNotFoundError => error
			# 	puts "↓ would fail but skipped to reduce spam"
			# end
		# end
	end

	# class KnowledgeBit
	# 	belongs_to :type, class_name: "KnowledgeBitType", inverse_of: :knowledge_bits
	# end

	# class KnowledgeBitType
	# 	has_many :knowledge_bits, inverse_of: :type, foreign_key: "type_id"
	# end
	#
	# We want to check that “type” in `inverse_of: :type` on `KnowledgeBitType`
	# matches the “type” in `belongs_to :type` on `KnowledgeBit`
	#
	# If `reflection = KnowledgeBit.reflect_on_association(:type)`
	# and `inverse_reflection = `
	# then, the `belongs_to :type` on `KnowledgeBit` is `reflection.name`
	# and the `has_many :knowledge_bits, inverse_of: :type` is `inverse_reflection.options[:inverse_of]`
	#
	# ---
	#
	# But what about polymorphic many-to-many
	#
	# class Conception
	#   has_many :conception_associations, dependent: :destroy,      inverse_of: :conception
	#   has_many :quiz_questions, through: :conception_associations, inverse_of: :conceptions, source: :conceivable, source_type: "Quiz::Question", class_name: "Quiz::Question"
	#   has_many :conceivables,   through: :conception_associations, inverse_of: :conception,  source: :conceivable, source_type: "Conception"
	# end
	#
	# class ConceptionAssociation
	#   belongs_to :conception,  inverse_of: :conception_associations
	#   belongs_to :conceivable, inverse_of: :conception_associations, polymorphic: true
	# end
	#
	# class Quiz::Question
	#   has_many :conception_associations, as: :conceivable, inverse_of: :conceivable
	#   has_many :conceptions,             as: :conceivable, inverse_of: :conceivables, through: :conception_associations
	# end
	#
	# class Lecture
	#   has_many :conception_associations, as: :conceivable, inverse_of: :conceivable, dependent: :destroy
	#   has_many :conceptions, through: :conception_associations, inverse_of: :conceivables
	# end
	#
	it "is expected to have `inverse_of` name match association name" do |example|
		fail "is expected to have inverse_of" unless subject.has_inverse?
		fail "is expected to have inverse_of" unless subject.inverse_of

		if subject.inverse_of.respond_to?(:options)
			inverse_name = subject.inverse_of.options[:inverse_of].presence || subject.inverse_of.name
			inspect_all_reflections(subject, "    ↓") if example.metadata[:debug] # https://relishapp.com/rspec/rspec-core/v/3-12/docs/metadata/user-defined-metadata
			expect(subject.name).to eq(inverse_name)
		end
	end
end

# WIP
shared_examples "has counter cache" do
	it { expect(subject.inverse_updates_counter_cache?).to be_truthy }
	it { expect(subject.inverse_updates_counter_in_memory?).to be_truthy }
	it { expect(subject.inverse_which_updates_counter_cache).to be_truthy }
end

shared_examples "check a has_many_through reflection" do
	it { is_expected.to be_through_reflection }
	it { is_expected.to be_a ActiveRecord::Reflection::ThroughReflection }
end

shared_examples "check a has_many reflection" do
	it { is_expected.to be_a ActiveRecord::Reflection::HasManyReflection }
end

shared_examples "correct empty collection" do
	# Must be declared on the example group:
	#
	# let(:association_name) { :knowledge_bits }
	# subject { described_class.reflect_on_association(association_name) }

	it { expect(described_class.new.public_send(association_name)).to be_none }

	it "counts 0" do
		expect(described_class.new.public_send(association_name).count).to eq 0
	end
end

shared_examples "<< for persisted association" do
	# Must be declared on the example group:
	#
	# let(:persisted_record) { create :quiz_question }
	# let(:association_name) { :knowledge_bits }
	# subject { described_class.reflect_on_association(association_name) }

	# reflection.active_record             #=> Quiz::Question
	# persisted_base_record                #=> @quiz_question
	# association_name                     #=> :knowledge_bits
	# reflection.klass                     #=>  KnowledgeBit
	# reflection.klass.model_name.singular #=> "knowledge_bit"
	# persisted_association                #=>  create :knowledge_bit

	let(:persisted_base_record) { create described_class.model_name.singular.to_sym }
	let(:persisted_association) { create persisted_association_factory_name }
	let(:persisted_association_factory_name) { subject.name.to_s.singularize.to_sym }
	let(:association_scope) { persisted_base_record.public_send(association_name)	}

	it ".name eq .klass.model_name.singular" do
		expect(subject.klass.model_name.singular).to eq subject.name.to_s.singularize
	end

	it "is able to build association" do
		expect { association_scope.build }.not_to raise_exception
	end

	it "count changes from 0 to 1" do
		expect { association_scope << persisted_association }.to change { association_scope.count }.from(0).to(1)
	end

	# it do
	# 	inspect_all_reflections(subject, "    ↓")
	# end
end
