export default function AdminHomePage() {
  return (
    <main className="flex min-h-screen flex-col items-center justify-between p-12">
      <div className="z-10 max-w-5xl w-full items-center justify-between font-mono text-sm lg:flex border-b border-gray-200 pb-6">
        <p className="fixed left-0 top-0 flex w-full justify-center border-b border-gray-300 bg-gradient-to-b from-zinc-200 pb-6 pt-8 backdrop-blur-2xl lg:static lg:w-auto lg:rounded-xl lg:border lg:bg-gray-200 lg:p-4">
          ScamPlay Private Admin Web &bull; Milestone M1
        </p>
        <div className="fixed bottom-0 left-0 flex h-48 w-full items-end justify-center bg-gradient-to-t from-white via-white lg:static lg:h-auto lg:w-auto lg:bg-none">
          <span className="inline-flex items-center px-3 py-1 rounded-full text-xs font-semibold bg-blue-100 text-blue-800">
            Environment Initialized
          </span>
        </div>
      </div>

      <div className="relative flex place-items-center my-12">
        <div className="text-center">
          <h1 className="text-4xl font-extrabold tracking-tight text-gray-900 sm:text-5xl">
            ScamPlay Administration
          </h1>
          <p className="mt-4 text-base text-gray-600 max-w-2xl">
            Private management portal for bilingual digital safety scenarios, verified emergency contacts, and rights-cleared multimedia assets.
          </p>
        </div>
      </div>

      <div className="mb-32 grid text-center lg:max-w-5xl lg:w-full lg:mb-0 lg:grid-cols-3 lg:text-left gap-6">
        <div className="group rounded-lg border border-gray-200 px-5 py-4 transition-colors hover:border-gray-300 hover:bg-gray-100">
          <h2 className="mb-3 text-lg font-semibold text-gray-900">
            Scenario Pipeline{" "}
            <span className="inline-block transition-transform group-hover:translate-x-1 motion-reduce:transform-none">
              &rarr;
            </span>
          </h2>
          <p className="m-0 max-w-[30ch] text-sm text-gray-500">
            Draft, review, and publish bilingual scenario nodes and decisions (Target M5).
          </p>
        </div>

        <div className="group rounded-lg border border-gray-200 px-5 py-4 transition-colors hover:border-gray-300 hover:bg-gray-100">
          <h2 className="mb-3 text-lg font-semibold text-gray-900">
            Security & RLS{" "}
            <span className="inline-block transition-transform group-hover:translate-x-1 motion-reduce:transform-none">
              &rarr;
            </span>
          </h2>
          <p className="m-0 max-w-[30ch] text-sm text-gray-500">
            Least-privilege PostgreSQL access and authenticated administrative roles.
          </p>
        </div>

        <div className="group rounded-lg border border-gray-200 px-5 py-4 transition-colors hover:border-gray-300 hover:bg-gray-100">
          <h2 className="mb-3 text-lg font-semibold text-gray-900">
            Media Management{" "}
            <span className="inline-block transition-transform group-hover:translate-x-1 motion-reduce:transform-none">
              &rarr;
            </span>
          </h2>
          <p className="m-0 max-w-[30ch] text-sm text-gray-500">
            License verification and asset delivery for Khmer/English audio & covers.
          </p>
        </div>
      </div>
    </main>
  );
}
