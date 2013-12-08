frontend.Routes = Routes =
  companies:   "companies"
  newCompany:  "companies/new"
  company:     "companies/:id"
  editCompany: "companies/:id/edit"
  "":          "dashboard"

frontend.root = root = "/"

frontend.Paths =
  companies:           -> root + Routes.companies
  newCompany:          -> root + Routes.newCompany
  company:        (id) -> root + Routes.company.replace(":id", id)
  editCompany:    (id) -> root + Routes.editCompany.replace(":id", id)
