indexing
	description: "Implemented `IEiffelFeatureDescriptor' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	IEIFFEL_FEATURE_DESCRIPTOR_IMPL_STUB

inherit
	IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE

	ECOM_STUB

feature -- Access

	name: STRING is
			-- Feature name.
		do
			-- Put Implementation here.
		end

	external_name: STRING is
			-- Feature external name.
		do
			-- Put Implementation here.
		end

	written_class: STRING is
			-- Name of class where feature is written in.
		do
			-- Put Implementation here.
		end

	evaluated_class: STRING is
			-- Name of class where feature was evaluated in.
		do
			-- Put Implementation here.
		end

	description: STRING is
			-- Feature description.
		do
			-- Put Implementation here.
		end

	signature: STRING is
			-- Feature signature.
		do
			-- Put Implementation here.
		end

	all_callers: IENUM_FEATURE_INTERFACE is
			-- List of all feature callers, includding callers of ancestor and descendant versions.
		do
			-- Put Implementation here.
		end

	all_callers_count: INTEGER is
			-- Number of all callers.
		do
			-- Put Implementation here.
		end

	local_callers: IENUM_FEATURE_INTERFACE is
			-- List of feature callers.
		do
			-- Put Implementation here.
		end

	local_callers_count: INTEGER is
			-- Number of local callers.
		do
			-- Put Implementation here.
		end

	descendant_callers: IENUM_FEATURE_INTERFACE is
			-- List of feature callers, including callers of descendant versions.
		do
			-- Put Implementation here.
		end

	descendant_callers_count: INTEGER is
			-- Number of descendant callers.
		do
			-- Put Implementation here.
		end

	implementers: IENUM_FEATURE_INTERFACE is
			-- List of implementers.
		do
			-- Put Implementation here.
		end

	implementer_count: INTEGER is
			-- Number of feature implementers.
		do
			-- Put Implementation here.
		end

	ancestor_versions: IENUM_FEATURE_INTERFACE is
			-- List of ancestor versions.
		do
			-- Put Implementation here.
		end

	ancestor_version_count: INTEGER is
			-- Number of ancestor versions.
		do
			-- Put Implementation here.
		end

	descendant_versions: IENUM_FEATURE_INTERFACE is
			-- List of descendant versions.
		do
			-- Put Implementation here.
		end

	descendant_version_count: INTEGER is
			-- Number of descendant versions.
		do
			-- Put Implementation here.
		end

	exported_to_all: BOOLEAN is
			-- Is feature exported to all classes?
		do
			-- Put Implementation here.
		end

	is_once: BOOLEAN is
			-- Is once feature?
		do
			-- Put Implementation here.
		end

	is_external: BOOLEAN is
			-- Is external feature?
		do
			-- Put Implementation here.
		end

	is_deferred: BOOLEAN is
			-- Is deferred feature?
		do
			-- Put Implementation here.
		end

	is_constant: BOOLEAN is
			-- Is constant?
		do
			-- Put Implementation here.
		end

	is_frozen: BOOLEAN is
			-- is frozen feature?
		do
			-- Put Implementation here.
		end

	is_infix: BOOLEAN is
			-- Is infix?
		do
			-- Put Implementation here.
		end

	is_prefix: BOOLEAN is
			-- Is prefix?
		do
			-- Put Implementation here.
		end

	is_attribute: BOOLEAN is
			-- Is attribute?
		do
			-- Put Implementation here.
		end

	is_procedure: BOOLEAN is
			-- Is procedure?
		do
			-- Put Implementation here.
		end

	is_function: BOOLEAN is
			-- Is function?
		do
			-- Put Implementation here.
		end

	is_unique: BOOLEAN is
			-- Is unique?
		do
			-- Put Implementation here.
		end

	is_obsolete: BOOLEAN is
			-- Is obsolete feature?
		do
			-- Put Implementation here.
		end

	has_precondition: BOOLEAN is
			-- Does feature have precondition?
		do
			-- Put Implementation here.
		end

	has_postcondition: BOOLEAN is
			-- Does feature have postcondition?
		do
			-- Put Implementation here.
		end

feature -- Basic Operations

	feature_location (file_path: CELL [STRING]; line_number: INTEGER_REF) is
			-- Feature location, full path to file and line number
			-- `file_path' [in, out].  
			-- `line_number' [in, out].  
		do
			-- Put Implementation here.
		end

	create_item is
			-- Initialize `item'
		do
			item := ccom_create_item (Current)
		end

feature {NONE}  -- Externals

	ccom_create_item (eif_object: IEIFFEL_FEATURE_DESCRIPTOR_IMPL_STUB): POINTER is
			-- Initialize `item'
		external
			"C++ [new ecom_eiffel_compiler::IEiffelFeatureDescriptor_impl_stub %"ecom_eiffel_compiler_IEiffelFeatureDescriptor_impl_stub_s.h%"](EIF_OBJECT)"
		end

end -- IEIFFEL_FEATURE_DESCRIPTOR_IMPL_STUB

